package com.banamex.nearshore.catalogsms.domain;

import org.springframework.beans.factory.annotation.Autowired;

public class EmpleadoProveedor {

	private Integer id;
	private Integer idProvider;
	private Integer idEmployee;
	private String firstLastName;
	private String secondLastName;
	private String firstName;
	private String secondName;
	private String ldCelular;
	private String personalNumber;
	private String ldParticular;
	private String particularTelephone;
	private String personalEmail;
	@Autowired
	private PuestoProveedor puesto;
	@Autowired
	private Ciudad country;
	private String ldProvider;
	private String telephoneProvider;
	private String extension;
	private String emailProvider;
	private String soeId;
	private String ldCiti;
	private String citiTelephone;
	private String extCiti;
	private String emailCiti;
	private Integer idReportaA;
	private String comments;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getIdProvider() {
		return idProvider;
	}
	public void setIdProvider(Integer idProvider) {
		this.idProvider = idProvider;
	}
	public Integer getIdEmployee() {
		return idEmployee;
	}
	public void setIdEmployee(Integer idEmployee) {
		this.idEmployee = idEmployee;
	}
	public String getFirstLastName() {
		return firstLastName;
	}
	public void setFirstLastName(String firstLastName) {
		this.firstLastName = firstLastName;
	}
	public String getSecondLastName() {
		return secondLastName;
	}
	public void setSecondLastName(String secondLastName) {
		this.secondLastName = secondLastName;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getSecondName() {
		return secondName;
	}
	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}
	public Ciudad getCountry() {
		return country;
	}
	public void setCountry(Ciudad country) {
		this.country = country;
	}
	public String getPersonalNumber() {
		return personalNumber;
	}
	public void setPersonalNumber(String personalNumber) {
		this.personalNumber = personalNumber;
	}
	public String getParticularTelephone() {
		return particularTelephone;
	}
	public void setParticularTelephone(String particularTelephone) {
		this.particularTelephone = particularTelephone;
	}
	public String getPersonalEmail() {
		return personalEmail;
	}
	public void setPersonalEmail(String personalEmail) {
		this.personalEmail = personalEmail;
	}
	public PuestoProveedor getPuesto() {
		return puesto;
	}
	public void setPuesto(PuestoProveedor puesto) {
		this.puesto = puesto;
	}
	public Integer getIdReportaA() {
		return idReportaA;
	}
	public void setIdReportaA(Integer idReportaA) {
		this.idReportaA = idReportaA;
	}
	public String getTelephoneProvider() {
		return telephoneProvider;
	}
	public void setTelephoneProvider(String telephoneProvider) {
		this.telephoneProvider = telephoneProvider;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getEmailProvider() {
		return emailProvider;
	}
	public void setEmailProvider(String emailProvider) {
		this.emailProvider = emailProvider;
	}
	public String getSoeId() {
		return soeId;
	}
	public void setSoeId(String soeId) {
		this.soeId = soeId;
	}
	public String getExtCiti() {
		return extCiti;
	}
	public void setExtCiti(String extCiti) {
		this.extCiti = extCiti;
	}
	public String getEmailCiti() {
		return emailCiti;
	}
	public void setEmailCiti(String emailCiti) {
		this.emailCiti = emailCiti;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getLdCelular() {
		return ldCelular;
	}
	public void setLdCelular(String ldCelular) {
		this.ldCelular = ldCelular;
	}
	public String getLdParticular() {
		return ldParticular;
	}
	public void setLdParticular(String ldParticular) {
		this.ldParticular = ldParticular;
	}
	public String getLdProvider() {
		return ldProvider;
	}
	public void setLdProvider(String ldProvider) {
		this.ldProvider = ldProvider;
	}
	public String getLdCiti() {
		return ldCiti;
	}
	public void setLdCiti(String ldCiti) {
		this.ldCiti = ldCiti;
	}
	public String getCitiTelephone() {
		return citiTelephone;
	}
	public void setCitiTelephone(String citiTelephone) {
		this.citiTelephone = citiTelephone;
	}
}
