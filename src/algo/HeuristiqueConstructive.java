package algo;

import java.util.ArrayList;
import java.util.List;
import metier.Client;
import metier.Instance;
import metier.Vehicule;

/**
 * Implémente des algorithmes heuristiques constructifs
 * @author user
 */
public class HeuristiqueConstructive {
	private Instance instance;

	/**
	 * Constrcuteur par données.
	 * @param instance TODO
	 */
	public HeuristiqueConstructive(Instance instance) {
		this.instance = instance;
	}

	/**
	 * 
	 */
	public void insertionSimple() {
		this.instance.clear();
		List<Client> clients = this.instance.getClients();
		List<Vehicule> vehicules = this.instance.getVehicules();
		List<Vehicule> vehiculesUtilises = new ArrayList<>();

		for (Client c : clients) {
			boolean affecte = false;
			for (Vehicule v : vehiculesUtilises) {
				if (v.addClient(c)) {
					affecte = true;
					break;
				}
			}
			if (!affecte) {
				if (vehicules.isEmpty()) {
					System.out.println("Erreur : Plus de vehicule dispo pour "
							+ "affecter le client " + c);
				} else {
					Vehicule v = vehicules.remove(0);
					this.instance.addVehiculeInPlanning(v);
					if (!v.addClient(c)) {
						System.out.println("Erreur : client " + c + " n'a pas "
								+ "pu être affecté au vehicule " + v);
					}
					vehiculesUtilises.add(v);
				}
			}
		}

		this.instance.updatePositions();
		if (!instance.checkPlanning()) {
			System.out.println("Solution FAUSSE !!!");
		}
		else {
			System.out.println("Solution BONNE !!!");
		}
	}
}
