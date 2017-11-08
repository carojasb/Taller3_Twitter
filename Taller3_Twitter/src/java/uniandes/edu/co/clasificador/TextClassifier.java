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

/**
 *
 * @author Kmilo
 */
public class TextClassifier {

    public ClasificadorAbs classifier;
        
    public void loadModel(String file) throws Exception{
            classifier = ClasificadorAbs.cargarModeloToDummy(file);            
    }
    
    public String classify(String text) throws Exception{
        Instance i = InstancesManager.createInstanceFromText(text, classifier.getHeader(), false);        
        return "" + i.stringValue(i.classAttribute());        
    }
    
}
