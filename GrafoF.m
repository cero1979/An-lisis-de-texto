datos = readmatrix('conexionF.csv');
nodos = datos(:, 1:2);
pesos = datos(:, 3);


tabla = table(nodos, pesos, 'VariableNames', {'Nodes', 'Weight'});


tabla.Nodes = sort(tabla.Nodes, 2);


tabla = unique(tabla, 'rows', 'stable');

figure;
grafo = graph(tabla.Nodes(:, 1), tabla.Nodes(:, 2), tabla.Weight, 'OmitSelfLoops');
plot(grafo, 'EdgeLabel', grafo.Edges.Weight);


