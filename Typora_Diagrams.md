This is a Pathway Analysis/Cause andEffect graphic showing what variables are playing a role in my experiment.
```mermaid
graph TD
	A((Environment)) -->|"Selection on SNPS <br/>(Local Adaptation)"| B[GI Variants]
	B --- C("General Stress Exposure <br/>(Salinity, Drought, Heat, and Cold)") 
	C --> D{Chlorophyll <br/>Fluorescence}
	C --> E{Survival Rate}
	B -->|Cold Stress| F{Electrolyte Leakage}
	B-->G{Flowering Time/Bolting}
	H((Experimental <br/>Design)) -->|Non-native Background| B
```
This is a logic tree for the next steps of my experiment. I will be transforming *Arabidopsis thaliana* mutants with gene variants to identify if local adaptation is at play on GI in *P. balsamifera*.
```mermaid
graph LR
	A(Are gi2 mutants homozygous?)--> B((NO))
	B --> C(Grow heterozygotes and cross them)
	A --> D((YES))
	D--> E(Were mutants successfully transformed?)
	E--> F((NO))
	F--> G(Troubleshoot)
	E--> H((YES))
	H--> I("Do they respond differentially to stresses <br/>(ie. cold, drought, heat, salinity)?")
	I--> J((NO))
	J--> K(Is this a product of experimental design <br/>or is GI not locally adapted for stress response?)
	I--> L((YESS))
	L--> M(Do these differences correlate to environmental gradients as expected?)
	M--> N((NO))
	N--> O(Is GI playing a different role?)
	M--> P((YES))
	P--> Q(Local adaption is present and GI <br/>has been impacted by this selection.)

```
