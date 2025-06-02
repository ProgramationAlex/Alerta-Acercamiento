% Supongamos que ya tienes cargados los vectores THreltrue (longitud relativa)
% y deltatrue (latitud) con los datos de los satélites.
% Y ahora, también tienes cargado el vector R_mag (magnitud del vector de posición).

% Definir el umbral de distancia a la caja de control
distancia_umbral = 0.05;

% Definir el radio geoestacionario y su tolerancia (en km)
radio_geostacionario = 42164; % km
tolerancia_radio = 300; % km

% Inicializar un vector para almacenar los índices del primer punto de los cruces dentro de la caja
cruces_dentro_caja_indices = [];

% Inicializar un vector para almacenar los índices del primer punto de los cruces de signo
cruces_signo_indices = [];

% Iterar a través de los segmentos de línea (pares de puntos contiguos)
for i = 1:(length(THreltrue) - 1)
  longitud1 = THreltrue(i);
  longitud2 = THreltrue(i + 1);
  latitud1 = deltatrue(i);
  latitud2 = deltatrue(i + 1);

  % Esta es la fórmula de distancia angular original que estás usando.
  % Como mencionaste, si funciona para tu propósito inicial de filtro rápido, puedes mantenerla.
  delta_rao = 2 * asind(sqrt((sind(latitud1 / 2)).^2 + cosd(latitud1) * (sind(latitud1 / 2)).^2));

  if delta_rao < 0.05
    cruces_signo_indices = [cruces_signo_indices, i];
  else
    % Verificar cambio de signo en longitud
    cambio_signo_longitud = (longitud1 > 0 && longitud2 < 0) || (longitud1 < 0 && longitud2 > 0) || (longitud1 == 0 || longitud2 == 0);

    % Verificar cambio de signo en latitud
    cambio_signo_latitud = (latitud1 > 0 && latitud2 < 0) || (latitud1 < 0 && latitud2 > 0) || (latitud1 == 0 || latitud2 == 0);

    % Si hay un cambio de signo simultáneo en longitud y latitud, registrar el índice
    if (cambio_signo_longitud && cambio_signo_latitud)
      cruces_signo_indices = [cruces_signo_indices, i];
    end
  end
end

% Analizar los cruces de signo para verificar si la trayectoria pasa a una distancia menor o igual al umbral del origen
for indice_cruce = cruces_signo_indices
  i = indice_cruce;
  longitud1 = THreltrue(i);
  longitud2 = THreltrue(i + 1);
  latitud1 = deltatrue(i);
  latitud2 = deltatrue(i + 1);

  % La recta que une los dos puntos es (x(t), y(t)) = (longitud1 + t*(longitud2 - longitud1), latitud1 + t*(latitud2 - latitud1))
  % donde t va de 0 a 1.
  % La distancia al origen al cuadrado es D^2(t) = x(t)^2 + y(t)^2
  % D^2(t) = (longitud1 + t*delta_long)^2 + (latitud1 + t*delta_lat)^2
  % donde delta_long = longitud2 - longitud1 y delta_lat = latitud2 - latitud1

  delta_long = longitud2 - longitud1;
  delta_lat = latitud2 - latitud1;

  % Para encontrar la distancia mínima al origen, podemos derivar D^2(t) con respecto a t e igualar a cero.
  % d(D^2)/dt = 2*(longitud1 + t*delta_long)*delta_long + 2*(latitud1 + t*delta_lat)*delta_lat = 0
  % (longitud1 + t*delta_long)*delta_long + (latitud1 + t*delta_lat)*delta_lat = 0
  % longitud1*delta_long + t*delta_long^2 + latitud1*delta_lat + t*delta_lat^2 = 0
  % t*(delta_long^2 + delta_lat^2) = - (longitud1*delta_long + latitud1*delta_lat)
  % t_min = - (longitud1*delta_long + latitud1*delta_lat) / (delta_long^2 + delta_lat^2)

  denominador = delta_long^2 + delta_lat^2;
  if (denominador ~= 0)
    t_min = - (longitud1*delta_long + latitud1*delta_lat) / denominador;

    % El valor de t_min debe estar entre 0 y 1 para que el punto de mínima distancia esté en el segmento.
    if (t_min >= 0 && t_min <= 1)
      distancia_min_cuadrado = (longitud1 + t_min*delta_long)^2 + (latitud1 + t_min*delta_lat)^2;
      distancia_min = sqrt(distancia_min_cuadrado);
      if (distancia_min <= distancia_umbral)
        % *** NUEVO CRITERIO: Verificar la magnitud del radio ***
        % Es importante que R_mag(i) sea el radio correspondiente a THreltrue(i) y deltatrue(i)
        % Es decir, R_mag debe tener la misma longitud que THreltrue y deltatrue
        if R_mag(i) > (radio_geostacionario - tolerancia_radio) && R_mag(i) < (radio_geostacionario + tolerancia_radio)
          cruces_dentro_caja_indices = [cruces_dentro_caja_indices, i];
        end
      end
    else
      % Si t_min no está entre 0 y 1, la distancia mínima ocurre en uno de los extremos del segmento.
      distancia_punto1 = sqrt(longitud1^2 + latitud1^2);
      distancia_punto2 = sqrt(longitud2^2 + latitud2^2);
      if (distancia_punto1 <= distancia_umbral || distancia_punto2 <= distancia_umbral)
        % *** NUEVO CRITERIO: Verificar la magnitud del radio para ambos puntos extremos ***
        % Aquí también debes verificar ambos puntos ya que la distancia mínima podría estar en cualquiera de ellos.
        condicion_radio_punto1 = R_mag(i) > (radio_geostacionario - tolerancia_radio) && R_mag(i) < (radio_geostacionario + tolerancia_radio);
        condicion_radio_punto2 = R_mag(i+1) > (radio_geostacionario - tolerancia_radio) && R_mag(i+1) < (radio_geostacionario + tolerancia_radio);

        if (condicion_radio_punto1 || condicion_radio_punto2)
          cruces_dentro_caja_indices = [cruces_dentro_caja_indices, i];
        end
      end
    end
  else
    % Si el denominador es cero, los dos puntos son iguales, así que verificamos la distancia de ese punto al origen.
    distancia_punto1 = sqrt(longitud1^2 + latitud1^2);
    if (distancia_punto1 <= distancia_umbral)
      % *** NUEVO CRITERIO: Verificar la magnitud del radio ***
      if R_mag(i) > (radio_geostacionario - tolerancia_radio) && R_mag(i) < (radio_geostacionario + tolerancia_radio)
        cruces_dentro_caja_indices = [cruces_dentro_caja_indices, i];
      end
    end
  end
end

for i = 1 : length(cruces_dentro_caja_indices)
  estado(cruces_dentro_caja_indices(i),:); % Asumiendo que 'estado' es una variable que quieres procesar.
end