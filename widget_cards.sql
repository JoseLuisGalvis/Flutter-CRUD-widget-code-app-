-- Creación de la base de datos
DROP DATABASE IF EXISTS widget_cards;
CREATE DATABASE widget_cards;
USE widget_cards;

CREATE TABLE categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  image VARCHAR(255) NOT NULL,
  description TEXT NOT NULL
);

INSERT INTO categories (title, image, description)
VALUES 	('Usabilidad', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/accessibility.png', 'Mejora la accesibilidad de la aplicación.'),
		('Animacion y Movimientos', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/animation.png', 'Agrega animaciones a los widgets.'),
		('Activos Imagen e Icono', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/estados.png', 'Administra activos, muestra imagenes e iconos.'),
		('Gestion de Estado', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/estados.png', 'Funcionalidad para manejar el estado de la aplicacion de manera eficiente.'),
		('Basicos', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/basicos.png', 'Widgets esenciales para el desarrollo de aplicaciones Flutter.'),
		('Cupertino', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/cupertino.png', 'Widgets hermosos y de alta fidelidad para estilos iOS.'),
		('Entrada', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/entrada.jpeg', 'Entrada del usuario y de los widgets en Componentes de Material y Cupertino.'),
		('Navegacion', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/navegacion.jpeg', 'Responde a eventos tactiles y dirige a los usuarios a diferentes vistas.'),
		('Layout', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/layout.jpeg', 'Organiza otros widgets, columnas, filas, cuadriculas y otros diseños.'),
		('Componentes de Material', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/material.jpeg', 'Widgets visuales, comportamentales y ricos en movimiento.'),
		('Efectos Visuales', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/material.jpeg', 'Widgets que añaden cambios visuales a sus hijos sin cambiar su diseño y forma.'),
		('Desplazamiento', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/animation.png', 'Desplaza multiples widgets como hijos de los padres.'),
        ('Tema y Apariencia', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/tema.png', 'Se ocupa del tema, responsividad y tamaño de la aplicacion.'),
		('Texto', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/text.png', 'Muestra y Estiliza Texto.'),
		('Seguridad y Autenticacion', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/security.png', 'Autenticacion y Autorizacion.');
        

DESCRIBE categories;
SELECT * FROM categories;

TRUNCATE TABLE categories;

DROP TABLE  categories;


CREATE TABLE widgets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  category_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  image VARCHAR(255) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

DESCRIBE widgets;
SELECT * FROM widgets;

TRUNCATE TABLE widgets;

DROP TABLE  widgets;

SELECT w.*, c.title AS category_title
FROM widgets w
JOIN categories c ON w.category_id = c.id
WHERE w.category_id = 2;

SELECT c.*, w.* 
FROM categories c 
LEFT JOIN widgets w ON c.id = w.category_id
WHERE c.id = 1;

UPDATE widgets
SET category_id = 3
WHERE category_id = 2;

INSERT INTO widgets (category_id, name, description, image)
VALUES
  (1, 'TextField', 'Permite la entrada de texto simple, ideal para formularios y captura de datos básicos.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/textfield.jpeg'),
  (1, 'CheckboxListTile', 'Combina un checkbox con una etiqueta, facilitando la selección de opciones en interfaces de usuario.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/checkboxlistTile.jpeg'),
  (1, 'Switch', 'Proporciona un interruptor de encendido/apagado, útil para configuraciones binarias como activar/desactivar funciones.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/switch.jpeg'),
  (2, 'AnimatedBuilder', 'Construye un widget hijo utilizando una instancia de Animation.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/animatedbuilder.jpeg'),
  (2, 'AnimatedCrossFade', 'Realiza una transición cruzada entre dos widgets hijos, con una animación personalizable.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/animatedcrossfade.jpeg'),
  (2, 'AnimatedOpacity', 'Cambia la opacidad de un widget hijo de manera animada.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/animatedopacity.jpeg'),
  (3, 'Icon', 'Muestra un ícono de Material Design, en este caso, una imagen coloreada en negro.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/icon.jpeg'),
  (3, 'Image', 'Carga y muestra una imagen desde una URL especificada, ideal para contenido dinámico.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/imageWidget.jpeg'),
  (3, 'FadeInImage', 'Muestra una imagen con una transición de fadeIn, útil para imágenes cargadas desde la red o archivos locales.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/fadeInImage.jpeg'),
  (4, 'StatefulWidget', 'Estado mutable que se puede cambiar después de que se ha construido.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/statefulwidget.jpeg'),
  (4, 'ValueListenableBuilder', 'Se reconstruye cuando el valor de un ValueListenable cambia.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/valuelistenablebuilder.jpeg'),
  (4, 'StreamBuilder', 'Se reconstruye cuando el valor de un Stream cambia.', 'https://raw.githubusercontent.com/JoseLuisGalvis/Dart-Flutter-WidgetApp/master/assets/images/streambuilder.jpeg');


  
  