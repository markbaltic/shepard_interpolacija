# shepard_interpolacija
Implementacije interpolacijskih metod analiziranih v magistrskem delu ter praktični preizkus na analitični funkciji *peaks*.

## Metode:
* *shep2D* — klasični Shepardov operator na 2D podatkih,
* *shep_taylor2D* — Taylor-Shepardov operatod na 2D podatkih. Aproksimacije odvodov izračuna s pomočjo funkcije *aproksimiraj_z_ravnino*,
* *k_shep2D* — *k*-Shepardov operator na 2D podatkih, ki za izračun vrednosti točke upošteva le *k* najbližjih sosedov,
* *k_shep_taylor2D* — kombinacija Taylor-Shepardovega in *k*-Shepardovega operatorja na 2D podatkih,
* *triang_shepard2D* — triangulacijski Shepardov operator na 2D podatkih. Vrednosti linearnih interpolantov nad trikotniki izračuna s pomočjo funkcije *interpolant_baricentric*.
* *shep2Dp* — klasičnu Shepardov operator, kjer lahko poljubno spremenimo parameter izbranih uteži.

## Preizkus na analitični funkciji *peaks*
V datoteki *eksperiment_peaks* je napisan preizkus metod na analitični funkciji *peaks*. Za določitev razpršene množice 
podatkov uporablja funkcijo *izbor_tock_pravokotniki*.
