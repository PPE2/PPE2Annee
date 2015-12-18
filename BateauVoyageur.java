package MarieTeam;

import java.util.ArrayList;

public class BateauVoyageur extends Bateau{
	private double vitesseBatVoy;
	private String imageBatVoy;
	private ArrayList <Equipement> lesEquipements;
	private String valeurs;
	
	public BateauVoyageur (String unId, String unNom, double uneLongueur, double uneLargeur, double uneVitesse, String uneImage, ArrayList<Equipement> uneCollEquip){
		super(unId, unNom, uneLongueur, uneLargeur);
		this.vitesseBatVoy = uneVitesse;
		this.imageBatVoy = uneImage;
		this.lesEquipements = uneCollEquip;
	}
	
	public String toString(){
		valeurs =  "Nom  du bateau : " + super.toString() + System.getProperty("Line.separator") + "Vitesse : " + vitesseBatVoy + System.getProperty("Line.separator");
		valeurs += "Liste des équipements du bateau :" + System.getProperty("Line.separator");
		for (Equipement unEquip : lesEquipements){
			valeurs += "- " + unEquip.toString() + System.getProperty("Line.separator");
		}
		return valeurs;	
	}
	
	public String getImageBatVoy(){
		return imageBatVoy;
	}
}
