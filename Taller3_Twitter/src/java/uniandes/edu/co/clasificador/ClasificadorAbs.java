package uniandes.edu.co.clasificador;

import java.util.Vector;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SerializationHelper;

public abstract class ClasificadorAbs {
	protected Classifier cl;
	private Instances header;
	private boolean entrenado=false;
	/**
	 * Carga un modelo entrenado desde archivo.
	 * @param file URI del archivo del modelo serializado
	 * */
	public  void cargarModelo(String file) throws Exception{
	    Object o=SerializationHelper.read(file);
	    if(o instanceof Vector){
	    	@SuppressWarnings("unchecked")
			Vector<Object> v =  (Vector<Object>) o;
	    	this.cl = (Classifier) v.get(0);
	    	this.header = (Instances) v.get(1);
	    	entrenado=true;
	    }else if(o instanceof Classifier){
	    	this.cl=(Classifier) o;
	    	Object[] o2=SerializationHelper.readAll(file);
	    	if(o2.length>1&&o2[1] instanceof Instances){
	    		this.header=(Instances)o2[1];
	    		entrenado=true;
	    	}
	    	
	    }
            	    
	}
	/**
	 * Carga un modelo entrenado desde archivo en un clasificador Dummy, 
	 * este clasificador dummy funciona, cuando se carga desde un archivo, como el clasificador que lo guardÃ³.
	 * @param file URI del archivo del modelo serializado
	 * */
	public static ClasificadorAbs cargarModeloToDummy(String file) throws Exception{
		ClasificadorAbs cabs=new DummyClassifier();
		cabs.cargarModelo(file);
		return cabs;
	}
	
	public void guardarModelo(String file)throws Exception{
		Vector <Object> v =new Vector<Object>();
		if(entrenado){
			v.add(cl);
			v.add(header);
			SerializationHelper.writeAll(file, v.toArray());
		}else{
			throw new Exception("El modelo no ha sido entrenado");
		}
	}
	public abstract void entrenar(Instances instances) throws Exception;
        
	public void clasificar(Instances instances){}
        
	public Double clasificar(Instance inst) throws Exception{
		if(cl!=null){
			double pred = cl.classifyInstance(inst);
			return pred;
		}
		return null;
	}
        
	public boolean isEntrenado(){
		return entrenado;
	}
	public void setEntrenado(boolean entrenado) {
		this.entrenado = entrenado;
	}
	public Instances getHeader(){
		return header;
	}
	protected void setHeader(Instances header){
		this.header=header;
	}
}
