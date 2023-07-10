datos = readmatrix('conexionF.csv');
nodos = datos(:, 1:2);
pesos = datos(:, 3);

% Crear una tabla con los datos
tabla = table(nodos, pesos, 'VariableNames', {'Nodes', 'Weight'});

% Ordenar los nodos en cada fila de forma ascendente
tabla.Nodes = sort(tabla.Nodes, 2);

% Eliminar las filas duplicadas manteniendo solo la primera aparición
tabla = unique(tabla, 'rows', 'stable');

% Construir el grafo y graficarlo
figure;
grafo = graph(tabla.Nodes(:, 1), tabla.Nodes(:, 2), tabla.Weight, 'OmitSelfLoops');
plot(grafo, 'EdgeLabel', grafo.Edges.Weight);


