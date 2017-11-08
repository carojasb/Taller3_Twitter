/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uniandes.edu.co.clasificador;

import weka.core.Instances;

public class DummyClassifier extends ClasificadorAbs {

	@Override
	public void entrenar(Instances instances) throws Exception {
		throw new Exception("El clasificador dummy no se puede entrenar, por favor cree una instancia de otro clasificador");
	}

}
