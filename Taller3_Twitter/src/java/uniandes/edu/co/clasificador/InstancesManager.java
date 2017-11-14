/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uniandes.edu.co.clasificador;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import weka.classifiers.Classifier;
import weka.classifiers.meta.FilteredClassifier;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SparseInstance;
import weka.core.converters.ConverterUtils.DataSource;
import weka.core.stemmers.SnowballStemmer;
import weka.core.stemmers.Stemmer;
import weka.core.tokenizers.Tokenizer;
import weka.core.tokenizers.WordTokenizer;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.StringToWordVector;

public class InstancesManager {
	private static Stemmer s=new SnowballStemmer("english");
;
	public static Instances getInstancesFromFile(String file) throws Exception{
		DataSource ds=new DataSource(file); 
		Instances insts=ds.getDataSet();
		return insts;
	}
	public static Instances getInstancesFromFile(String file, String clase) throws Exception{
		Instances insts=getInstancesFromFile(file);
		insts.setClass(insts.attribute(clase));
		return insts;
	}
	public static Instances getHeaderFromFile(String file) throws Exception{
		DataSource ds=new DataSource(file); 
		Instances insts=ds.getStructure();
		return insts;
	}
	public static Instance newInstance(Map<String,String> contenido, Instances header){
		Instance tmp=new DenseInstance(contenido.size());
		for (String k:contenido.keySet()){
			tmp.setValue(header.attribute(k).index(), contenido.get(k));
		}
		tmp.setDataset(header);
		return tmp;
	}
	public static Instance newInstance(Map<Integer,String> contenido){
		Instance tmp=new DenseInstance(contenido.size());
		for (int k:contenido.keySet()){
			tmp.setValue(k, contenido.get(k));
		}
		return tmp;
	}
	public static Map<Integer,String> getAttributos(Instances insts){
		Map<Integer,String> atributos=new HashMap<Integer,String>();
		@SuppressWarnings("unchecked")
		Enumeration<Attribute> test=insts.enumerateAttributes();
		while(test.hasMoreElements()){
			Attribute ne=test.nextElement();
			atributos.put(ne.index(),ne.name());
		}
		return atributos;
	}
	public static Instance createInstanceFromText(String cuenta, String text, String retweet, int seguidores, int favoritos, String locacion, Instances header, boolean useStemmer) throws Exception {
		
            Instance i = new SparseInstance(5);
            i.setDataset(header);                        
            i.setValue(header.attribute(0), cuenta);
            i.setValue(header.attribute(1), text);
            i.setValue(header.attribute(2), retweet);
            i.setValue(header.attribute(3), seguidores);
            i.setValue(header.attribute(4), favoritos);
            i.setValue(header.attribute(5), locacion);

            System.out.println("esto es i = " + i);
                        
            return i;		          
	}
        
        public static Instance createInstanceFromTextIngles(int tweet_id, String fecha, String content, String author_name, String author_nickname, 
            String rating_1, String rating_2, String rating_3, String rating_4, Instances header, boolean useStemmer) throws Exception {
		
            Instance i = new SparseInstance(5);
            i.setDataset(header);                        
            i.setValue(header.attribute(0), tweet_id);
            i.setValue(header.attribute(1), fecha);
            i.setValue(header.attribute(2), content);
            i.setValue(header.attribute(3), author_name);
            i.setValue(header.attribute(4), author_nickname);
            i.setValue(header.attribute(5), rating_1);
            i.setValue(header.attribute(6), rating_2);
            i.setValue(header.attribute(7), rating_3);
            i.setValue(header.attribute(8), rating_4);

            System.out.println("esto es i = " + i);
                        
            return i;		          
	}
}
