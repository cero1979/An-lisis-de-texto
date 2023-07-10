data = readmatrix('conexionF.csv');
num_nodos = max(max(data(:, 1)), max(data(:, 2)));
matriz_adyacencia = zeros(num_nodos, num_nodos);
num_aristas = size(data, 1);
for i = 1:num_aristas
    origen = data(i, 1);
    destino = data(i, 2);
    peso = data(i, 3);
    matriz_adyacencia(origen, destino) = peso;
    matriz_adyacencia(destino, origen) = peso; % Si el grafo es no dirigido
end

% Crear un objeto de grafo ponderado vacío
grafo = graph();

% Agregar los nodos al grafo
num_nodos = size(matriz_adyacencia, 1);
grafo = addnode(grafo, num_nodos);

% Recorrer la matriz de adyacencia y agregar las aristas con sus pesos al grafo
for i = 1:num_nodos
    for j = 1:num_nodos
        peso = matriz_adyacencia(i, j);
        if peso > 0
            grafo = addedge(grafo, i, j, peso);
        end
    end
end

% Calcular métricas de centralidad para cada nodo
eigenvector_centrality = centrality(grafo, 'eigenvector');
betweenness_centrality = centrality(grafo, 'betweenness');
closeness_centrality = centrality(grafo, 'closeness');
degree_centrality = centrality(grafo, 'degree');
clustering_coefficient = clustering_coef_bu(matriz_adyacencia);
% Calcular la matriz de distancias entre todos los pares de nodos
dist_matrix = distances(grafo);

% Calcular la excentricidad de cada nodo
excentricidades = max(dist_matrix, [], 2);



% Obtener el número total de nodos en el grafo
num_nodos = numnodes(grafo);

% Generar una matriz de identificadores de nodos
nodos = (1:num_nodos)';

% Crear una tabla con los resultados de las métricas de cada nodo
tabla_metricas = table(nodos, eigenvector_centrality, betweenness_centrality, closeness_centrality, degree_centrality, clustering_coefficient,excentricidades);

% Especificar los nombres de las columnas
tabla_metricas.Properties.VariableNames = {'Nodo', 'Eigenvector Centrality', 'Betweenness Centrality', 'Closeness Centrality', 'Degree Centrality', 'Clustering Coefficient','Exccentricity'};

% Escribir la tabla en un archivo CSV
writetable(tabla_metricas, 'metricas_nodos.csv', 'Delimiter', ',');

% Confirmar la escritura del archivo
disp('Archivo CSV creado exitosamente.');
% Mostrar los resultados
num_nodos = numnodes(grafo);
for i = 1:num_nodos
    fprintf('Nodo %d:\n', i);
    fprintf('Eigenvector centrality: %f\n', eigenvector_centrality(i));
    fprintf('Betweenness centrality: %f\n', betweenness_centrality(i));
    fprintf('Closeness centrality: %f\n', closeness_centrality(i));
    fprintf('Degree centrality: %f\n', degree_centrality(i));
    fprintf('Clustering coefficient: %f\n', clustering_coefficient(i));
    fprintf('Exccentricity: %f\n',excentricidades(i,:) );
    fprintf('-----------------------------\n');
end
% Mostrar las excentricidades de cada nodo


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
% figure;
% h = plot(grafo,"EdgeLabel",grafo.Edges.Weight);
% %h = plot(grafo, 'EdgeLabel', grafo.Edges.Weight);
% h.NodeLabel = cellstr(num2str((1:num_nodos)'));