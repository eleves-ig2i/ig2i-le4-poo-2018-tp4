package metier;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 * Entité représentant une instance.
 * @author user
 */
@Entity
@Table(name = "INSTANCE")
@XmlRootElement
@NamedQueries({
		@NamedQuery(name = "Instance.findAll",
			query = "SELECT i FROM Instance i"),
		@NamedQuery(name = "Instance.findById",
			query = "SELECT i FROM Instance i WHERE i.id = :id"),
		@NamedQuery(name = "Instance.findByNom",
			query = "SELECT i FROM Instance i WHERE i.nom = :nom")
})

public class Instance implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Integer id;

	@Column(name = "NOM")
	private String nom;

	@OneToMany(mappedBy = "ninstance")
	private Set<Point> pointSet;

	@OneToMany(mappedBy = "ninstance")
	private Set<Planning> planningSet;

	@OneToMany(mappedBy = "ninstance")
	private Set<Vehicule> vehiculeSet;

	/**
	 * Constructeur par défault.
	 */
	public Instance() {
		this.planningSet = new HashSet<>();
		this.vehiculeSet = new HashSet<>();
		this.pointSet = new HashSet<>();
	}

	/**
	 * Constructeur par données.
	 * @param nom TODO
	 */
	public Instance(String nom) {
		this.nom = nom;
	}

	public Integer getId() {
		return id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	@XmlTransient
	public Set<Point> getPointSet() {
		return pointSet;
	}

	@XmlTransient
	public Set<Planning> getPlanningSet() {
		return planningSet;
	}

	@XmlTransient
	public Set<Vehicule> getVehiculeSet() {
		return vehiculeSet;
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
		if (!(object instanceof Instance)) {
			return false;
		}
		Instance other = (Instance) object;
		if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "metier.Instance[ id=" + id + " ]";
	}

}
