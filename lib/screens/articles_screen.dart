import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/crisis_badge_button.dart';
import '../widgets/psychologist_card.dart';

class ArticleItem {
  const ArticleItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.readingTime,
    required this.content,
    required this.author,
  });

  final String id;
  final String title;
  final String subtitle;
  final String readingTime;
  final List<String> content;
  final String author;
}

// Contenido provisional: la psicóloga asesora del proyecto debe
// revisar y, en su caso, reemplazar estos textos.
const articlesList = <ArticleItem>[
  ArticleItem(
    id: 'pasos',
    title: 'Cuando todo cuesta más trabajo',
    subtitle: 'Por qué empezar con algo pequeño sí hace una diferencia.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Hay temporadas en las que levantarse, bañarse o contestar un mensaje se siente como subir una montaña. No es flojera: el ánimo bajo puede quitarle energía a casi todo.',
      'Esperar a "tener ganas" para hacer algo suele no funcionar. Muchas veces pasa al revés: hacer algo pequeño ayuda a que aparezcan un poco de energía y de ánimo.',
      'Elige una actividad de pocos minutos, como abrir la ventana o caminar alrededor de la casa. Cuando la termines, reconócelo. Ese paso cuenta.',
    ],
  ),
  ArticleItem(
    id: 'amabilidad',
    title: 'Hablarte con amabilidad',
    subtitle: 'Cómo responder a esa voz que te critica todo el tiempo.',
    readingTime: '4 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Cuando el ánimo está bajo es común ser muy duros con nosotros mismos: "no sirvo para nada", "todo lo hago mal". Esos pensamientos se sienten verdaderos, pero no siempre lo son.',
      'Prueba esto: imagina que un amigo te dice lo mismo sobre sí. ¿Qué le responderías? Intenta decirte algo parecido a ti.',
      'Hablarte con amabilidad no es mentirte ni ignorar lo difícil. Es tratarte con el mismo respeto que le darías a alguien que quieres.',
    ],
  ),
  ArticleItem(
    id: 'rutina',
    title: 'Sueño, comida y rutina',
    subtitle: 'Pequeños hábitos que sostienen el día cuando el ánimo baja.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'El ánimo, el sueño y la alimentación están muy conectados. Cuando uno cambia, los otros suelen moverse también.',
      'Intenta mantener horarios parecidos para dormir y despertar, aunque no tengas que ir a ningún lado. Comer algo a horas regulares, aunque sea poco, también ayuda.',
      'Si notas cambios fuertes en tu sueño o tu apetito que duran varias semanas, coméntalo con un profesional de la salud.',
    ],
  ),
  ArticleItem(
    id: 'conexion',
    title: 'No tienes que estar solo/a',
    subtitle: 'Acercarte a otros cuando tienes ganas de alejarte de todo.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Cuando nos sentimos mal, es común querer encerrarnos y no hablar con nadie. Aislarse puede parecer un descanso, pero con el tiempo puede hacer que todo pese más.',
      'No necesitas contar todo. Puedes empezar con un mensaje sencillo: "¿Cómo estás?" o "¿Te late ver una serie juntos?".',
      'Si te cuesta encontrar a alguien, un psicólogo o la Línea de la Vida (800 911 2000) también son personas dispuestas a escucharte.',
    ],
  ),
  ArticleItem(
    id: 'psicologo',
    title: 'El valor de consultar con un psicólogo',
    subtitle: 'Por qué hablar con un profesional hace la diferencia.',
    readingTime: '3 min de lectura',
    author: 'Psic. Asesora de Respira',
    content: [
      'Ir al psicólogo no es solo para momentos extremos. Es un espacio seguro y confidencial donde puedes entender lo que sientes y aprender herramientas hechas a tu medida.',
      'Solo un profesional puede valorar lo que estás viviendo. Una app, un test o un artículo pueden orientarte, pero no reemplazan esa atención.',
      'Dar el paso de buscar apoyo es un acto de cuidado hacia ti. Si no sabes por dónde empezar, pregunta en tu escuela, trabajo o centro de salud.',
    ],
  ),
];

ArticleItem articleById(String id) =>
    articlesList.firstWhere((a) => a.id == id, orElse: () => articlesList.first);

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
                'Lecturas para ti',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lecturas breves para entender lo que sientes y cuidarte en los días difíciles.',
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
              builder: (_) => ArticleDetailScreen(article: article),
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

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({required this.article, super.key});

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
              const SizedBox(height: 12),
              const PsychologistCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
