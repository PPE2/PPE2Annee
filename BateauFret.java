package MarieTeam;

import java.util.ArrayList;



public class BateauFret extends Bateau{
	private double poidsMaxBatFret;
	
	public BateauFret (String unId, String unNom, double uneLongueur, double uneLargeur, double unPoids){
		super(unId, unNom, uneLongueur, uneLargeur);
		this.poidsMaxBatFret = unPoids;

	}
}
