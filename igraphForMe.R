# Working through igraph
# April 17, 2018
# EAT

setwd("~/Documents/UVM_2018/BIO381")

# I am going to work through a tutorial found at the following URL to learn about igraph and then figure out what to use from that that will be useful to the class. http://kateto.net/networks-r-igraph

# Install the package
# install.packages("igraph")

# load the library
library(igraph)

# create undirected graph with three edges.the number are vertices (nodes) and so the edges are 1->2, 2->3.
g1 <- graph(edges = c(1,2,2,3,3,1), n=3, directed = F)
plot(g1)

# what is the class of this object?
class(g1)
# [1] "igraph"

# If you just print the variable the graph was assigned to, it gives you information on it
g1

# IGRAPH 7f1bd81 U--- 3 3 -- 
#   + edges from 7f1bd81:
#   [1] 1--2 2--3 1--3

# This time I want 10 vertices and it will be directed (directed is default)

g2 <- graph(edges = c(1,2,2,3,3,1), n=10)
plot(g2)
g2

# IGRAPH f409eda D--- 10 3 -- 
#   + edges from f409eda:
#   [1] 1->2 2->3 3->1

# the vertices don't need to necessarily be numbers, they can be names
g3 <- graph(c("John", "Jim", "Jim", "Jill", "Jill", "John"))
plot(g3) # again they are directional by default
g3

# IGRAPH aefe36e DN-- 3 3 -- 
#   + attr: name (v/c)
# + edges from aefe36e (vertex names):
#   [1] John->Jim  Jim ->Jill Jill->John

# You can specify isolates when they vertices are named (you can also have arrows to oneself or multiple arrows to the same person from the same person)
g4 <- graph(c("John", "Jim", "Jim", "Jack", "Jim", "Jack", "John", "John"), isolates = c("Jesse", "Janis", "Jennifer", "Justin"))
plot(g4)
# Add things to the graph
plot(g4, edge.arrow.size=0.5, vertex.color="gold", vertex.size=15,
     vertex.frame.color="gray", vertex.label.color="black",
     vertex.label.cex=0.8, vertex.label.dist=2,edge.curved=0.2) # note, this put the double arrow from Jim to Jack as one arrow

# you can make small graphs by indicating the edges
plot(graph_from_literal(a--b,b--c)) # the number of dashes doesn't matter
# you can also direct the edges
plot(graph_from_literal(a-+b,b+--c))
plot(graph_from_literal(a+-+b,b++c))
plot(graph_from_literal(a:b:c--c:d:e))
g5 <- graph_from_literal(a-b-c-d-e-f,a-g-h-b,h-e:f:i,j)
plot(g5) # if you keep replotting it will change its conformation

################################################################# Edge, vertex, and network attributes

# access vertices and edges
E(g4) # the edges
# + 4/4 edges from 32b064d (vertex names):
#   [1] John->Jim  Jim ->Jack Jim ->Jack John->John

V(g4) # vertices of object
# + 7/7 vertices, named, from 32b064d:
#   [1] John     Jim      Jack     Jesse    Janis    Jennifer Justin

# look at the matrix network
g4[]
# 7 x 7 sparse Matrix of class "dgCMatrix"
# John Jim Jack Jesse Janis Jennifer Justin
# John        1   1    .     .     .        .      .
# Jim         .   .    2     .     .        .      .
# Jack        .   .    .     .     .        .      .
# Jesse       .   .    .     .     .        .      .
# Janis       .   .    .     .     .        .      .
# Jennifer    .   .    .     .     .        .      .
# Justin      .   .    .     .     .        .      .

g4[1,] # provides you with the first row and each column of that row
# John      Jim     Jack    Jesse    Janis Jennifer   Justin 
# 1        1        0        0        0        0        0 

# Add attributes to the network, vertices, or edges:
V(g4)$name # automatically generated when we created the network
# [1] "John"     "Jim"      "Jack"     "Jesse"    "Janis"    "Jennifer" "Justin" 

V(g4)$gender <- c("male", "male", "male", "male", "female", "female", "male") # add attribute(gender) to each of the vertices
E(g4)$type <- "email" # add edge attribute, assign "email" to all edges
E(g4)$weight <- 10 # add edge weight, setting all existing edges to 10 (notice weight is a column name)

# View the newly added edge attributes
edge_attr(g4)
# $type
# [1] "email" "email" "email" "email"
# 
# $weight
# [1] 10 10 10 10

# View the vertex attributes
vertex_attr(g4)
# [1] "John"     "Jim"      "Jack"     "Jesse"    "Janis"    "Jennifer" "Justin"  
# 
# $gender
# [1] "male"   "male"   "male"   "male"   "female" "female" "male" 

graph_attr(g4)
# named list()

# another way to set attributes:
g4 <- set_graph_attr(g4, "name","Email Network")
g4 <- set_graph_attr(g4, "something", "A thing")
graph_attr_names(g4)
# [1] "name"      "something"
graph_attr(g4, "name")
# [1] "Email Network"
graph_attr(g4)
# $name
# [1] "Email Network"
# 
# $something
# [1] "A thing"

# delete attributes
g4 <- delete_graph_attr(g4, "something")
graph_attr(g4)
# $name
# [1] "Email Network"
plot(g4, edge.arrow.size=0.5, vertex.label.color="black",vertex.label.dist=1.5,
     vertex.color=c("pink","skyblue")[1+(V(g4)$gender=="male")]) # makes males blue

# tell it what arrows to actually graph
g4 <- simplify(g4, remove.multiple = T, remove.loops = F, edge.attr.comb = c(weight="sum", type="ignore"))
plot(g4, vertex.label.dist=1.5)
g4
# IGRAPH d160ad9 DNW- 7 3 -- Email Network
# + attr: name (g/c), name (v/c), gender (v/c), weight (e/n)
# + edges from d160ad9 (vertex names):
#   [1] John->John John->Jim  Jim ->Jack

# The description of an igraph object starts with up to four letters:
#   
# D or U, for a directed or undirected graph
# N for a named graph (where nodes have a name attribute)
# W for a weighted graph (where edges have a weight attribute)
# B for a bipartite (two-mode) graph (where nodes have a type attribute)
# The two numbers that follow (7 5) refer to the number of nodes and edges in the graph. The description also lists node & edge attributes, for example:
#   
#   (g/c) - graph-level character attribute
# (v/c) - vertex-level character attribute
# (e/n) - edge-level numeric attribute

############################################################### Specific graphs and graph models

# make an empty graph
eg <- make_empty_graph(40)
plot(eg, vertex.size=10, vertex.label=NA)

# make full graph
fg <- make_full_graph(40)
plot(fg, vertex.size=10, vertex.label=NA)

# Simple star graph
st <- make_star(40)
plot(st, vertex.size=10, vertex.label=NA) 

# Tree graph
tr <- make_tree(40, children = 3, mode = "undirected")
plot(tr, vertex.size=10, vertex.label=NA)

# ring graph
rn <- make_ring(40)
plot(rn, vertex.size=10, vertex.label=NA)

# Erdos-Renyi random graph model (n is the number of nodes, m is the number of edges)
er <- sample_gnm(n=100, m=40)
plot(er, vertex.size=6, vertex.label=NA)  

# Watts-Strogatz small-world model
# Creates a lattice (with dim dimensions and size nodes across dimension) and rewires edges randomly with 
# probability p. The neighborhood in which edges are connected is nei. You can allow loops and multiple edges.
sw <- sample_smallworld(dim=2, size=10, nei=1, p=0.1)
plot(sw, vertex.size=6, vertex.label=NA, layout=layout_in_circle)

# Barabasi-Albert preferential attachment model for scale-free graphs
# (n is number of nodes, power is the power of attachment (1 is linear); m is the number of edges added on each time step)
ba <-  sample_pa(n=100, power=1, m=1,  directed=F)
plot(ba, vertex.size=6, vertex.label=NA)

# notable historic graphs
zach <- graph("Zachary") # the Zachary carate club
plot(zach, vertex.size=10, vertex.label=NA)

# Rewiring a graph
# each_edge() is a rewiring method that changes the edge endpoints uniformly randomly with a probability prob.
rn.rewired <- rewire(rn, each_edge(prob=0.1))
plot(rn.rewired, vertex.size=10, vertex.label=NA)

# Rewire to connect vertices to other vertices at a certain distance.
rn.neigh = connect.neighborhood(rn, 5)
plot(rn.neigh, vertex.size=8, vertex.label=NA) 

#Combine graphs (disjoint union, assuming separate vertex sets): %du%
plot(rn, vertex.size=10, vertex.label=NA) 
plot(tr, vertex.size=10, vertex.label=NA) 
plot(rn %du% tr, vertex.size=10, vertex.label=NA) 

##################################################################### Using Data from file
# I downloaded two files, one with nodes and one with edges
nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)
head(nodes)
# id               media media.type type.label audience.size
# 1 s01            NY Times          1  Newspaper            20
# 2 s02     Washington Post          1  Newspaper            25
# 3 s03 Wall Street Journal          1  Newspaper            30
# 4 s04           USA Today          1  Newspaper            32
# 5 s05            LA Times          1  Newspaper            20
# 6 s06       New York Post          1  Newspaper            50
head(links)
# from  to weight      type
# 1  s01 s02     10 hyperlink
# 2  s01 s02     12 hyperlink
# 3  s01 s03     22 hyperlink
# 4  s01 s04     21 hyperlink
# 5  s04 s11     22   mention
# 6  s05 s15     21   mention

nrow(nodes); length(unique(nodes$id))
# [1] 17
# [1] 17
nrow(links); nrow(unique(links[,c("from", "to")]))
# [1] 52
# [1] 49

# We will collapse all links of the same type between the same two nodes by summing their weights, using aggregate() by “from”, “to”, & “type”. We don’t use simplify() here so as not to collapse different link types.
links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
colnames(links)[4] <- "weight"
rownames(links) <- NULL

# data set 2
# Two-mode or bipartite graphs have two different types of actors and links that go across, but not within each type. Our second media example is a network of that kind, examining links between news sources and their consumers.

nodes2 <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)
head(nodes2)
# id   media media.type media.name audience.size
# 1 s01     NYT          1  Newspaper            20
# 2 s02    WaPo          1  Newspaper            25
# 3 s03     WSJ          1  Newspaper            30
# 4 s04    USAT          1  Newspaper            32
# 5 s05 LATimes          1  Newspaper            20
# 6 s06     CNN          2         TV            56
head(links2)
# U01 U02 U03 U04 U05 U06 U07 U08 U09 U10 U11 U12 U13 U14 U15 U16 U17 U18 U19 U20
# s01   1   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
# s02   0   0   0   1   1   0   0   0   0   0   0   0   0   0   0   0   0   0   0   1
# s03   0   0   0   0   0   1   1   1   1   0   0   0   0   0   0   0   0   0   0   0
# s04   0   0   0   0   0   0   0   0   1   1   1   0   0   0   0   0   0   0   0   0
# s05   0   0   0   0   0   0   0   0   0   0   1   1   1   0   0   0   0   0   0   0
# s06   0   0   0   0   0   0   0   0   0   0   0   0   1   1   0   0   1   0   0   0

# We can see that links2 is an adjacency matrix for a two-mode network:
links2 <- as.matrix(links2)
dim(links2)
dim(nodes2)

##################################################################### Turning networks into igraph objects
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
class(net)
# info in net
E(net)       # The edges of the "net" object
V(net)       # The vertices of the "net" object
E(net)$type  # Edge attribute "type"
V(net)$media # Vertex attribute "media"

# first plotting attempt
plot(net, edge.arrow.size=.4,vertex.label=NA)
# remove loops
net <- simplify(net, remove.multiple = F, remove.loops = T) 
plot(net)

# If you need them, you can extract an edge list or a matrix from igraph networks.
as_edgelist(net, names=T)
as_adjacency_matrix(net, attr="weight")

# Or data frames describing nodes and edges:
as_data_frame(net, what="edges")
as_data_frame(net, what="vertices")

# Data set 2
nodes2 <- read.csv("Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)
head(nodes2)
head(links2)
links2 <- as.matrix(links2)
dim(links2)
dim(nodes2)

######################################### Turning networks into igraph objects
# using graph.data.frame we will take two data frames to make an igraph object

# d describes the edges of the network. Its first two columns are the IDs of the source
# and the target node for each edge. The following columns are edge attributes (weight, 
# type, label, or anything else).
# vertices starts with a column of node IDs. Any following columns are interpreted as node attributes.

net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
class(net)
net
E(net)       # The edges of the "net" object
V(net)       # The vertices of the "net" object
E(net)$type  # Edge attribute "type"
V(net)$media
# plot it
plot(net, edge.arrow.size=.4,vertex.label=NA)
# remove loops with simplify
net <- simplify(net, remove.multiple = F, remove.loops = T) 
# extract edgelist or matrix
as_edgelist(net, names=T)
as_adjacency_matrix(net, attr="weight")
# or data frames
as_data_frame(net, what="edges")
as_data_frame(net, what="vertices")

# from data set 2 (bipartite form)
# bipartite means that there are two "groups" and each ead has one vertiex from one group and one vertex from the other group
net2 <- graph_from_incidence_matrix(links2)
# table of vertices in net2 that are True (1) or false (0)
table(V(net2)$type)
# calculation of bipartite projections
net2.bp <- bipartite.projection(net2)

############################################### Node Degrees
deg <- degree(net, mode="all")
plot(net, vertex.size=deg*3)
hist(deg, breaks=1:vcount(net)-1, main="Histogram of node degree")

# Degree distribution
deg.dist <- degree_distribution(net, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange", 
      xlab="Degree", ylab="Cumulative Frequency")
# Centrality and centralization --> Centrality functions (vertex level) and centralization functions (graph level)
# The centralization functions return res - vertex centrality, centralization, and theoretical_max - maximum 
# centralization score for a graph of that size.
# Degree (number of ties)
degree(net, mode="in")
# s01 s02 s03 s04 s05 s06 s07 s08 s09 s10 s11 s12 s13 s14 s15 s16 s17 
# 4   2   6   4   1   4   1   2   3   4   3   3   2   2   2   1   4
centr_degree(net, mode="in", normalized=T)
# $res
# [1] 4 2 6 4 1 4 1 2 3 4 3 3 2 2 2 1 4
# 
# $centralization
# [1] 0.1985294
# 
# $theoretical_max
# [1] 272

# Closeness (centrality based on distance to others in the graph)
# Inverse of the node’s average geodesic distance to others in the network.
closeness(net, mode="all", weights=NA) 
# s01        s02        s03        s04        s05        s06        s07        s08        s09        s10 
# 0.03333333 0.03030303 0.04166667 0.03846154 0.03225806 0.03125000 0.03030303 0.02857143 0.02564103 0.02941176 
# s11        s12        s13        s14        s15        s16        s17 
# 0.03225806 0.03571429 0.02702703 0.02941176 0.03030303 0.02222222 0.02857143 
centr_clo(net, mode="all", normalized=T)
# $res
# [1] 0.5333333 0.4848485 0.6666667 0.6153846 0.5161290 0.5000000 0.4848485 0.4571429 0.4102564 0.4705882 0.5161290
# [12] 0.5714286 0.4324324 0.4705882 0.4848485 0.3555556 0.4571429
# 
# $centralization
# [1] 0.3753596
# 
# $theoretical_max
# [1] 7.741935

# Eigenvector (centrality proportional to the sum of connection centralities)
# Values of the first eigenvector of the graph matrix.
eigen_centrality(net, directed=T, weights=NA)
centr_eigen(net, directed=T, normalized=T) 

# Betweenness (centrality based on a broker position connecting others)
# Number of geodesics that pass through the node or the edge.
betweenness(net, directed=T, weights=NA)
edge_betweenness(net, directed=T, weights=NA)
centr_betw(net, directed=T, normalized=T)

# hubs and authorities
# The hubs and authorities algorithm developed by Jon Kleinberg was initially used to examine web pages. 
# Hubs were expected to contain catalogs with a large number of outgoing links; while authorities would get 
# many incoming links from hubs, presumably because of their high-quality relevant information.
hs <- hub_score(net, weights=NA)$vector
as <- authority_score(net, weights=NA)$vector
par(mfrow=c(1,2))
plot(net, vertex.size=hs*50, main="Hubs")
plot(net, vertex.size=as*30, main="Authorities")
dev.off()

# subgroups and communities
# First I need to make my network undirected
# We can create an undirected link between any pair of connected nodes (mode="collapse")
# Create undirected link for each directed one in the network, potentially ending up with a multiplex graph (mode="each")
# Create undirected link for each symmetric link in the graph (mode="mutual").

net.sym <- as.undirected(net, mode= "collapse",
                         edge.attr.comb=list(weight="sum", "ignore"))
# Cliques
# Find cliques (complete subgraphs of an undirected graph)
cliques(net.sym) # list of cliques       
sapply(cliques(net.sym), length) # clique sizes
largest_cliques(net.sym) # cliques with max number of nodes
vcol <- rep("grey80", vcount(net.sym))
vcol[unlist(largest_cliques(net.sym))] <- "gold"
plot(as.undirected(net.sym), vertex.label=V(net.sym)$name, vertex.color=vcol)

# community detection
# A number of algorithms aim to detect groups that consist of densely connected nodes with fewer connections across groups.
# Community detection based on edge betweenness (Newman-Girvan)
# High-betweenness edges are removed sequentially (recalculating at each step) and the best partitioning of the network is selected.
ceb <- cluster_edge_betweenness(net) 
dendPlot(ceb, mode="hclust")
plot(ceb, net) 
length(ceb)     # number of communities
membership(ceb) # community membership for each node
modularity(ceb) # how modular the graph partitioning is
# High modularity for a partitioning reflects dense connections within communities and sparse connections across communities.

sites <- read.table(file = "Bad_SNPs_sites.kept.sites", header = T)
head(sites)
