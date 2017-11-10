/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uniandes.edu.co.clasificador;

import java.awt.GridLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

import weka.core.Instance;
import uniandes.edu.co.clasificador.ClasificadorAbs;
import uniandes.edu.co.clasificador.DummyClassifier;
import uniandes.edu.co.clasificador.InstancesManager;
import weka.classifiers.Classifier;
import weka.core.SparseInstance;

/**
 *
 * @author Kmilo
 */
public class TextClassifier {

    public ClasificadorAbs classifier;
    protected Classifier cl;
        
    public void loadModel(String file) throws Exception{
            
        classifier = ClasificadorAbs.cargarModeloToDummy(file);
        /*
        System.out.println("getHeader = " + classifier.getHeader());
        System.out.println("size = " + classifier.getHeader().size());

        Instance i = new SparseInstance(3);

        System.out.println("instance i = " + i);
        System.out.println("atributo 0 = " + classifier.getHeader().attribute(0).value(2));
        System.out.println("uniandes.edu.co.clasificador.TextClassifier.loadModel()"+i.attribute(0));

        i.setValue(classifier.getHeader().attribute(0), "bueno");
        i.setValue(classifier.getHeader().attribute(1), "camilo");
        i.setValue(classifier.getHeader().attribute(2), 1234);

        i.setDataset(classifier.getHeader());

        System.out.println("instance i despues de = " + i);
        System.out.println("Respuesta final = " + i.stringValue(i.classAttribute()));*/
    }
    
    public String classify(String text, String cuenta, int favoritos) throws Exception{
        Instance i = InstancesManager.createInstanceFromText(text, cuenta, favoritos, classifier.getHeader(), false);
        
        double pred = classifier.clasificar(i);
        String prediccion = "";
                        
        if (pred == 0){
            prediccion = "Bueno";
        }else if (pred == 1){
            prediccion = "Neutro";
        }else if (pred == 2){
            prediccion = "Malo";
        }
        
        return prediccion;
        //return "" + i.stringValue(i.classAttribute());
    }
    
}
