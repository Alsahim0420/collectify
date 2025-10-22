# 🧱 Collectify

![Collectify](https://res.cloudinary.com/panmecar/image/upload/v1756281903/ATHLOS/ATHLOS_banner_billey_remake_gywqzz.png)

---

**Collectify** es una aplicación móvil desarrollada en Flutter para gestionar y organizar colecciones de sets LEGO de manera inteligente, con funcionalidades offline-first y una experiencia de usuario moderna.

---

## ✨ Características Principales

### 🏠 **Gestión de Colecciones LEGO**
- **Lista de sets LEGO** con diseño de tarjetas moderno
- **Búsqueda y filtrado** de sets por nombre, tema o número
- **Estados de carga** con indicadores visuales
- **Navegación intuitiva** entre colecciones
- **Logo Collectify** con icono de bloques LEGO

### 📱 **Sistema de Temas Moderno**
- **Temas adaptativos** que se ajustan al sistema
- **Persistencia automática** usando Hive
- **Transición suave** entre temas
- **Adaptación automática** de todos los componentes
- **Diseño Material Design 3**

### 🔄 **Arquitectura Offline-First**
- **Carga instantánea** desde cache local (Hive)
- **Datos persistentes** entre sesiones
- **Funcionamiento completo** sin internet
- **Almacenamiento local** seguro y rápido
- **Sincronización** cuando hay conexión

### 🧱 **Gestión Completa de Sets LEGO**
- **Información detallada** de cada set
- **Número de serie** y tema del set
- **Cantidad de piezas** y notas personales
- **Fecha de adquisición** registrada
- **Organización por colecciones**

### 📊 **Estadísticas y Organización**
- **Contador de sets** en tiempo real
- **Estadísticas visuales** de la colección
- **Organización por temas** (Star Wars, Technic, etc.)
- **Búsqueda avanzada** por múltiples criterios
- **Vista detallada** de cada set

### 🎨 **Interfaz de Usuario Intuitiva**
- **Diseño moderno** con Material Design 3
- **Animaciones fluidas** y transiciones suaves
- **Componentes reutilizables** y consistentes
- **Responsive design** para diferentes pantallas
- **Feedback visual** en todas las interacciones

---

## 🖼️ Capturas de Pantalla

![Tema Oscuro - Home](https://res.cloudinary.com/panmecar/image/upload/v1756281138/ATHLOS/Screenshot_20250827_024604_heqgdb.jpg)

![Tema Oscuro - Home](https://res.cloudinary.com/panmecar/image/upload/v1756281139/ATHLOS/Screenshot_20250827_024621_zrjzb1.jpg)

![Tema Oscuro - Home](https://res.cloudinary.com/panmecar/image/upload/v1756281141/ATHLOS/Screenshot_20250827_024633_a4ej18.jpg)

![Tema Oscuro - Home](https://res.cloudinary.com/panmecar/image/upload/v1756282208/ATHLOS/Screenshot_20250827_030942_pdxom6.jpg)

![Detalle Ejercicio](https://res.cloudinary.com/panmecar/image/upload/v1756281143/ATHLOS/Screenshot_20250827_024903_rk9ohh.jpg)


![Perfil Usuario](https://res.cloudinary.com/panmecar/image/upload/v1756281144/ATHLOS/Screenshot_20250827_024908_pgyahq.jpg)

![Tema Claro - Home](https://res.cloudinary.com/panmecar/image/upload/v1756281181/ATHLOS/Screenshot_20250827_024912_w4m8uv.jpg)




---

## 🚀 Instalación y Configuración

### **Prerrequisitos**
- **Flutter SDK 3.32.8** o superior
- **Dart SDK 3.8.1** o superior
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

### **Clonar y Configurar**
```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/collectify.git
cd collectify

# Instalar dependencias
flutter pub get

# Generar código necesario
flutter packages pub run build_runner build

# Ejecutar la aplicación
flutter run
```

### **Configuración de Hive**
1. La aplicación usa Hive para almacenamiento local
2. Los adaptadores se generan automáticamente
3. No requiere configuración adicional de base de datos
4. Los datos se almacenan localmente en el dispositivo

---

## 🛠️ Tecnologías y Arquitectura

### **Frontend & UI**
- **Flutter 3.32.8** - Framework principal ⭐
- **Material Design 3** - Sistema de diseño moderno
- **Go Router 14.2.0** - Navegación declarativa ⭐
- **Responsive Design** - Adaptable a diferentes pantallas

### **Gestión de Estado**
- **Flutter Bloc 8.1.6** - State management reactivo ⭐
- **Equatable 2.0.5** - Comparación de objetos
- **Dartz 0.10.1** - Programación funcional
- **Clean Architecture** - Separación de responsabilidades

### **Almacenamiento Local**
- **Hive 2.2.3** - Base de datos local rápida ⭐
- **Hive Flutter 1.1.0** - Integración con Flutter ⭐
- **Hive Generator 2.0.1** - Generación de código ⭐
- **Shared Preferences 2.2.2** - Configuraciones simples
- **Type Adapters** - Serialización personalizada
- **Offline-First** - Datos persistentes localmente

### **Inyección de Dependencias**
- **Get It 7.7.0** - Service locator pattern ⭐
- **Dependency Injection** - Inyección de dependencias
- **Service Locator** - Patrón de localización de servicios
- **Singleton Pattern** - Instancias únicas

### **Serialización y Utilidades**
- **JSON Annotation 4.9.0** - Anotaciones para JSON ⭐
- **JSON Serializable 6.9.0** - Generación de serializadores
- **UUID 4.5.1** - Generación de identificadores únicos
- **Build Runner 2.4.13** - Generación de código ⭐

---

## 🏗️ Arquitectura del Proyecto

### **Estructura de Carpetas**
```
lib/
├── app/                           # Configuración de la aplicación
│   ├── di/                        # Inyección de dependencias
│   ├── routing/                   # Configuración de rutas
│   ├── theme/                     # Temas y estilos
│   └── utils/                     # Utilidades globales
├── data/                          # Capa de datos
│   ├── adapters/                  # Adaptadores Hive
│   ├── datasources/               # Fuentes de datos
│   ├── models/                    # Modelos de datos
│   └── repositories_impl/         # Implementaciones de repositorios
├── domain/                        # Capa de dominio
│   ├── entities/                  # Entidades de negocio
│   ├── failures/                  # Manejo de errores
│   ├── repositories/              # Interfaces de repositorios
│   └── usecases/                  # Casos de uso
└── presentation/                  # Capa de presentación
    ├── state/                     # Gestión de estado (BLoC)
    └── ui/                        # Interfaz de usuario
        ├── atoms/                 # Componentes atómicos
        ├── molecules/             # Componentes moleculares
        └── pages/                 # Páginas de la aplicación
```

### **Patrón de Diseño**
- **Clean Architecture** - Separación de responsabilidades
- **Repository Pattern** - Abstracción de datos
- **BLoC Pattern** - Gestión de estado reactiva
- **Dependency Injection** - Inyección de dependencias
- **Atomic Design** - Componentes modulares

---

## 🔧 Funcionalidades Técnicas

### **Gestión de Estado con BLoC**
```dart
class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionBloc(this._getLegoSets, this._addLegoSet, this._updateLegoSet, this._deleteLegoSet)
      : super(CollectionInitial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<UpdateItem>(_onUpdateItem);
    on<DeleteItem>(_onDeleteItem);
  }
}
```

### **Almacenamiento Local con Hive**
```dart
@HiveType(typeId: 0)
@JsonSerializable()
class LegoSetModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int setNumber;
  // ... más campos
}
```

### **Navegación con Go Router**
```dart
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'collections',
      builder: (context, state) => const CollectionsPage(),
    ),
    GoRoute(
      path: '/home/:collectionId',
      name: 'home',
      builder: (context, state) {
        final collectionId = state.pathParameters['collectionId']!;
        return HomePage(selectedCollectionId: collectionId);
      },
    ),
  ],
);
```

---

## 📱 Características de UX/UI

### **Diseño de Tarjetas Moderno**
- **Tarjetas elegantes** para cada set LEGO
- **Información clara** y bien organizada
- **Iconos temáticos** de bloques LEGO
- **Transiciones suaves** entre estados

### **Estados de Carga Intuitivos**
- **Indicadores de progreso** durante la carga
- **Estados vacíos** con mensajes motivacionales
- **Estados de error** con opciones de recuperación
- **Feedback visual** en todas las interacciones

### **Navegación Declarativa**
- **Go Router** para navegación declarativa
- **Rutas parametrizadas** para detalles
- **Navegación hacia atrás** intuitiva
- **Deep linking** preparado para futuras funcionalidades

---

## 🔒 Seguridad y Privacidad

### **Almacenamiento Local Seguro**
- **Hive** para almacenamiento local encriptado
- **Datos persistentes** entre sesiones
- **Sin dependencias** de servicios externos
- **Privacidad total** de los datos del usuario

### **Datos de la Colección**
- **Almacenamiento local** exclusivamente
- **No compartición** de datos personales
- **Control total** del usuario sobre sus datos
- **Cumplimiento** con estándares de privacidad

---

## 🚀 Despliegue y Distribución

### **Build de Producción**
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

### **Configuración de Release**
- **Proguard** para ofuscación de código
- **Signing** con keystore de producción
- **Optimizaciones** de rendimiento
- **Testing** en dispositivos reales

---

## 🧪 Testing y Calidad

### **Testing Unitario**
- **Flutter Lints 5.0.0** - Reglas de calidad de código ⭐
- **Build Runner 2.4.13** - Generación de código ⭐
- **Bloc Test 9.1.7** - Testing de BLoCs ⭐
- **Mocktail 1.0.3** - Mocks para testing ⭐
- **Models** con validaciones automáticas
- **Repository** con tests de integración

### **Testing de UI**
- **Widget testing** para componentes atómicos
- **Integration testing** para flujos completos
- **BLoC testing** para gestión de estado
- **Performance testing** para rendimiento

---

## 🤝 Contribución

### **Guidelines**
1. **Fork** del repositorio
2. **Feature branch** para cambios
3. **Commit messages** descriptivos
4. **Pull Request** con descripción clara
5. **Code review** obligatorio

### **Estándares de Código**
- **Dart/Flutter** linting rules
- **Clean Code** principles
- **Documentación** inline
- **Testing** para nuevas funcionalidades

---

## 👨‍💻 Desarrollador

**Desarrollado con 💙 por Pablo Melo**

- **GitHub**: [@Alsahim0420](https://github.com/Alsahim0420)
- **LinkedIn**: [Pablo Andrés Melo Carvajal](https://www.linkedin.com/in/pablo-andres-melo/)
- **Portfolio**: [alsahim0420.github.io](https://alsahim0420.github.io/portfolio/)

**⭐ Si te gusta Collectify, ¡dale una estrella al repositorio!**
