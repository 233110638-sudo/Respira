import 'package:flutter/material.dart';

import '../core_theme.dart';
import 'crisis_screen.dart';

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
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artículos de bienestar'),
        actions: [
          IconButton(
            tooltip: 'Necesito ayuda ahora',
            icon: const Icon(Icons.support_rounded, color: AppColors.alerta),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CrisisScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 32),
              children: [
                Text(
                  'Lecturas de nuestra psicóloga',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 6),
                Text(
                  'Textos breves con orientación práctica para cuidar de tu mente y tu cuerpo.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 22),
                for (final article in articlesList) ...[
                  _ArticleCard(article: article),
                  const SizedBox(height: 14),
                ],
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primarioClaro,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.psychology_outlined, color: AppColors.primario, size: 28),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Estos artículos son informativos. Si sientes que la sobrecarga persiste, te recomendamos consultar con un profesional de la psicología.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textoPrincipal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(article: article),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE8ECE8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primarioClaro,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      article.readingTime,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primario,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textoSecundario),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textoPrincipal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                article.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
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
      appBar: AppBar(
        title: const Text('Artículo'),
        actions: [
          IconButton(
            tooltip: 'Necesito ayuda ahora',
            icon: const Icon(Icons.support_rounded, color: AppColors.alerta),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CrisisScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primarioClaro,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    article.readingTime,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primario,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Por ${article.author}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFE8ECE8)),
                const SizedBox(height: 16),
                for (final paragraph in article.content) ...[
                  Text(
                    paragraph,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                ],
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1E9DD),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.psychology_rounded, color: Color(0xFF927449)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Recuerda: Este artículo no sustituye una consulta médica o psicológica. Si deseas un proceso personalizado, te invitamos a acudir con un psicólogo.',
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

