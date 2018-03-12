package metier;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Entité représentant un véhicule.
 * @author user
 */
@Entity
@Table(name = "VEHICULE")
@XmlRootElement
@NamedQueries({
		@NamedQuery(name = "Vehicule.findAll",
			query = "SELECT v FROM Vehicule v"),
		@NamedQuery(name = "Vehicule.findById",
			query = "SELECT v FROM Vehicule v WHERE v.id = :id"),
		@NamedQuery(name = "Vehicule.findByCout",
			query = "SELECT v FROM Vehicule v WHERE v.cout = :cout"),
		@NamedQuery(name = "Vehicule.findByCapaciteutilisee",
			query = "SELECT v FROM Vehicule v WHERE v.capaciteutilisee = :capaciteutilisee"),
		@NamedQuery(name = "Vehicule.findByCapacite",
			query = "SELECT v FROM Vehicule v WHERE v.capacite = :capacite")
})

public class Vehicule implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Integer id;

	@Column(name = "COUT")
	private double cout;

	@Column(name = "CAPACITEUTILISEE")
	private Integer capaciteutilisee;

	@Column(name = "CAPACITE")
	private Integer capacite;

	@OneToMany(mappedBy = "nvehicule")
	private Set<Client> ensClients;

	@JoinColumn(name = "NINSTANCE", referencedColumnName = "ID")
	@ManyToOne
	private Instance ninstance;

	@JoinColumn(name = "NPLANNING", referencedColumnName = "ID")
	@ManyToOne(optional = false)
	private Planning nplanning;

	@JoinColumn(name = "NDEPOT", referencedColumnName = "ID")
	@ManyToOne
	private Point ndepot;

	/**
	 * Constructeur par défault.
	 */
	public Vehicule() {
		this.ensClients = new HashSet<>();
	}

	/**
	 * Constructeur par données.
	 * @param id TODO
	 * @param depot TODO
	 * @param capacite TODO
	 */
	public Vehicule(Integer id,Point depot,Integer capacite) {
		this();
		this.id = id;
		if (capacite < 0) {
			capacite = 0;
		}
		this.capacite = capacite;
		this.capaciteutilisee = 0;
		this.cout = 0.0;
		this.ndepot = depot;
	}

	/**
	 * Constructeur par données.
	 * @param depot TODO
	 * @param capacite TODO
	 */
	public Vehicule(Point depot,Integer capacite) {
		this();
		if (capacite < 0) {
			capacite = 0;
		}
		this.capacite = capacite;
		this.capaciteutilisee = 0;
		this.cout = 0.0;
		this.ndepot = depot;
	}

	public Integer getId() {
		return id;
	}

	public double getCout() {
		return cout;
	}

	public void setCout(double cout) {
		this.cout = cout;
	}

	public Integer getCapaciteutilisee() {
		return capaciteutilisee;
	}

	public void setCapaciteutilisee(Integer capaciteutilisee) {
		this.capaciteutilisee = capaciteutilisee;
	}

	public Integer getCapacite() {
		return capacite;
	}

	public void setCapacite(Integer capacite) {
		this.capacite = capacite;
	}

	@XmlTransient
	public Set<Client> getEnsClients() {
		return ensClients;
	}

	public Instance getNinstance() {
		return ninstance;
	}

	public void setNinstance(Instance ninstance) {
		this.ninstance = ninstance;
	}

	public Planning getNplanning() {
		return nplanning;
	}

	public void setNplanning(Planning nplanning) {
		this.nplanning = nplanning;
	}

	public Point getNdepot() {
		return ndepot;
	}

	@Override
	public int hashCode() {
		int hash = 0;
		hash += (id != null ? id.hashCode() : 0);
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are not set
		if (!(object instanceof Vehicule)) {
			return false;
		}
		Vehicule other = (Vehicule) object;
		if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "Vehicule n°" + id + " [capacité max : " + capacite + " \n\t"
				+ "capacité utilisée : " + capaciteutilisee + " \n\tcoût : " + cout + "]";
	}

	/**
	 * Permet d'ajouter un client.
	 * @param c TODO
	 * @return Boolean
	 */
	public boolean addClient(Client c) {
		if (this.capaciteutilisee <= this.capacite) {
			if ((this.capaciteutilisee + c.getDemand() <= this.capacite)) {
				ArrayList clients = new ArrayList(this.ensClients);
				Point dernierPoint = null;
				if (clients.size() > 0) {
					dernierPoint = (Point) clients.get(clients.size() - 1);
				} else {
					dernierPoint = this.ndepot;
				}
				if (this.ensClients.add(c)) {
					this.setCapaciteutilisee(this.getCapaciteutilisee() + c.getDemand());
					this.setCout(this.getCout() + dernierPoint.getDistanceTo(c.getId()));
					this.getNplanning().setCout(this.getNplanning().getCout()
							+ dernierPoint.getDistanceTo(c.getId()));
					c.setNvehicule(this);
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

}
