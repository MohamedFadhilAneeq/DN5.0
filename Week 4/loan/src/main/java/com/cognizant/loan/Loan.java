package com.cognizant.loan;

public class Loan {
    private String number;
    private String type;
    private double loan;
    private double emi;
    private int tenure;

    public Loan(String number, String type, double loan, double emi, int tenure) {
        this.number = number;
        this.type = type;
        this.loan = loan;
        this.emi = emi;
        this.tenure = tenure;
    }

    // Getters
    public String getNumber() { return number; }
    public String getType() { return type; }
    public double getLoan() { return loan; }
    public double getEmi() { return emi; }
    public int getTenure() { return tenure; }
}