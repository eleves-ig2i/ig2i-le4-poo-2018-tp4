package metier;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Entité représentant un client.
 * @author user
 */
@Entity
@Table(name = "CLIENT")
@XmlRootElement
@NamedQueries({
		@NamedQuery(name = "Client.findAll",
			query = "SELECT c FROM Client c"),
		@NamedQuery(name = "Client.findByDemand",
			query = "SELECT c FROM Client c WHERE c.demand = :demand"),
		@NamedQuery(name = "Client.findByPosition",
			query = "SELECT c FROM Client c WHERE c.position = :position")
})
@DiscriminatorValue("2")
public class Client extends Point implements Serializable {

	@Column(name = "DEMAND")
	private int demand;

	@Column(name = "POSITION")
	private int position;

	@JoinColumn(name = "NVEHICULE", referencedColumnName = "ID")
	@ManyToOne
	private Vehicule nvehicule;

	/**
	 * Constructeur par défault.
	 */
	public Client() {
		super();
	}

	/**
	 * Constructeur par données.
	 * @param id TODO
	 * @param x TODO
	 * @param y TODO
	 * @param demand TODO
	 */
	public Client(Integer id, double x, double y, int demand) {
		super(id, x, y);
		this.demand = demand;
	}

	/**
	 * Constructeur par données.
	 * @param x TODO
	 * @param y TODO
	 * @param demand TODO
	 */
	public Client(double x, double y, int demand) {
		super(x, y);
		this.demand = demand;
	}

	public int getDemand() {
		return demand;
	}

	public void setDemand(int demand) {
		this.demand = demand;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public Vehicule getNvehicule() {
		return nvehicule;
	}

	public void setNvehicule(Vehicule nvehicule) {
		this.nvehicule = nvehicule;
	}

	@Override
	public String toString() {
		return "Client n°" + super.getId() + " [\n\t{ " + super.toString()
			+ " }\n\tdemande : " + demand + "\n\tposition : " + position + " ]";
	}

}
