import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';

class ArticleItem {
  const ArticleItem({
    required this.title,
    required this.subtitle,
    required this.readingTime,
    required this.content,
    required this.author,
  });

  final String title;
  final String subtitle;
  final String readingTime;
  final List<String> content;
  final String author;
}

const articlesList = <ArticleItem>[
  ArticleItem(
    title: 'Comprender las señales del cuerpo',
    subtitle: 'Cómo la tensión física nos avisa que necesitamos una pausa.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'A menudo ignoramos las pequeñas señales que el cuerpo nos envía: la mandíbula apretada, los hombros rígidos o la respiración acelerada. Estas reacciones son respuestas naturales del cuerpo cuando siente que debe estar alerta.',
      'Aprender a notar estas sensaciones sin juzgarlas es el primer paso para desactivar el estado de alarma. Una pequeña pausa para aflojar los hombros y respirar hondo le envía una señal de calma al sistema nervioso.',
      'Recuerda que estas señales son invitaciones a cuidarte, no defectos que debas eliminar a la fuerza.',
    ],
  ),
  ArticleItem(
    title: 'Pequeñas pausas conscientes en tu rutina',
    subtitle: 'Estrategias simples para recuperar el equilibrio durante el día.',
    readingTime: '4 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'No necesitas meditar durante una hora para notar una diferencia. Las micro-pausas de uno o dos minutos entre actividades permiten restablecer tu atención y bajar el ritmo acelerado.',
      'Prueba la regla de los tres momentos: al despertar, antes del almuerzo y al finalizar tu jornada, haz tres respiraciones lentas preguntándote: “¿Qué necesito en este instante?”.',
      'El descanso no es una recompensa por haber terminado todo; es una necesidad básica para funcionar con tranquilidad.',
    ],
  ),
  ArticleItem(
    title: 'El valor de consultar con un psicólogo',
    subtitle: 'Por qué hablar con un profesional de la salud mental hace la diferencia.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Ir al psicólogo no es exclusivo de momentos extremos. Es un espacio seguro y confidencial donde puedes ordenar pensamientos, comprender tus patrones emocionales y desarrollar herramientas a tu medida.',
      'Un acompañamiento profesional te permite mirar lo que estás viviendo con perspectiva y sin la carga del juicio cotidiano.',
      'Dar el paso de buscar apoyo es un acto de compromiso y cariño hacia tu propia vida.',
    ],
  ),
  ArticleItem(
    title: 'Cuando las preocupaciones se acumulan',
    subtitle: 'Cómo gestionar el exceso de pensamientos que dan vueltas.',
    readingTime: '4 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Cuando nos preocupamos en exceso, la mente intenta resolver futuros que aún no existen. Esto genera cansancio y sensación de agobio.',
      'Una técnica útil es plasmar las preocupaciones en papel. Al verlas escritas, se vuelven manejables y podemos distinguir lo que está bajo nuestro control de lo que no.',
      'Elegir soltar aquello que no depende de ti en este instante te devuelve energía para el presente.',
    ],
  ),
];

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({this.isEmbedded = false, super.key});

  final bool isEmbedded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isEmbedded)
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textoPrincipal,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  else
                    const SizedBox.shrink(),
                  const CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Artículos de bienestar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lecturas breves con orientación práctica para cuidar de tu mente.',
                style: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
              ),
              const SizedBox(height: 24),
              for (final article in articlesList) ...[
                _ArticleCard(article: article),
                const SizedBox(height: 14),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final ArticleItem article;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => _ArticleDetailScreen(article: article),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E6E3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.readingTime,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primario,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textoSecundario,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                article.subtitle,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textoSecundario,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleDetailScreen extends StatelessWidget {
  const _ArticleDetailScreen({required this.article});

  final ArticleItem article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textoPrincipal,
                      size: 22,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const CrisisBadgeButton(),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                article.readingTime,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primario,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                article.author,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 24),
              const Divider(height: 1, color: Color(0xFFE2E6E3)),
              const SizedBox(height: 24),
              for (final paragraph in article.content) ...[
                Text(
                  paragraph,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.6,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
