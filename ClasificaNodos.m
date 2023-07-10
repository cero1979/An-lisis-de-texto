
datos = readmatrix('metricas_nodos.csv', 'HeaderLines', 1);

cuartiles = zeros(3, 6); % Matriz para almacenar los cuartiles
for j = 1:6
    cuartiles(:, j) = prctile(datos(:, j), [25, 50, 75])';
end

N = size(datos, 1);  % Número de nodos
categorias = zeros(N, 18);


for i = 1:N
    for j = 1:6
        metrica = datos(i, j);
        cuartil_1 = cuartiles(1, j);
        cuartil_3 = cuartiles(3, j);
        
        if metrica >= cuartil_3  % Cuartil 4 (alto)
            categorias(i, (j-1)*3 + 1) = 1;
        elseif metrica >= cuartil_1  % Cuartil 2 y 3 (medio)
            categorias(i, (j-1)*3 + 2) = 1;
        else  % Cuartil 1 (bajo)
            categorias(i, (j-1)*3 + 3) = 1;
        end
    end
end

datos_con_categorias = [datos, categorias];

encabezados = ['Nodo', 'Eigenvector Centrality', 'Betweenness Centrality', 'Closeness Centrality', 'Degree Centrality', 'Clustering Coefficient', 'Exccentricity', 'Alto (EC)', 'Medio (EC)', 'Bajo (EC)', 'Alto (BC)', 'Medio (BC)', 'Bajo (BC)', 'Alto (CC)', 'Medio (CC)', 'Bajo (CC)', 'Alto (DC)', 'Medio (DC)', 'Bajo (DC)', 'Alto (CCo)', 'Medio (CCo)', 'Bajo (CCo)', 'Alto (Ex)', 'Medio (Ex)', 'Bajo (Ex)'];

resultado_csv = ['resultados.csv'];
writematrix(encabezados, resultado_csv, 'Delimiter', ',');
writematrix(datos_con_categorias, resultado_csv, 'Delimiter', ',', 'WriteMode', 'append');
