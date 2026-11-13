import 'package:flutter/material.dart';
import '../core_theme.dart';
import '../widgets/calm_scene.dart';
import '../widgets/crisis_badge_button.dart';
import 'crisis_screen.dart';

class SupportSomeoneScreen extends StatefulWidget {
  const SupportSomeoneScreen({this.isEmbedded = false, super.key});

  final bool isEmbedded;

  @override
  State<SupportSomeoneScreen> createState() => _SupportSomeoneScreenState();
}

class _SupportAccordionItem {
  const _SupportAccordionItem({
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;
}

class _SupportSomeoneScreenState extends State<SupportSomeoneScreen> {
  // Índice del elemento expandido (o null si ninguno)
  int? _expandedIndex;

  static const _items = <_SupportAccordionItem>[
    _SupportAccordionItem(
      title: 'Señales a las que poner atención',
      content: [
        '• Se le ve triste, apagado/a o sin energía la mayor parte del tiempo.',
        '• Dejó de hacer cosas que antes disfrutaba o se aleja de amigos y familia.',
        '• Cambios notorios en su sueño, su apetito o su cuidado personal.',
        '• Frases de desesperanza o de ser una carga (“ya nada tiene sentido”, “estarían mejor sin mí”).',
        '• Estas señales no son un diagnóstico: son motivos para acercarte y sugerir ayuda profesional.',
      ],
    ),
    _SupportAccordionItem(
      title: 'Cómo iniciar la conversación',
      content: [
        '• Busca un momento privado y sin prisas.',
        '• Habla de lo que has notado, sin juzgar: “Te he visto más callado/a últimamente, ¿cómo estás de verdad?”.',
        '• Escucha más de lo que hablas. No necesitas tener todas las respuestas.',
        '• Valida lo que siente: “Gracias por contármelo, se oye muy pesado”.',
      ],
    ),
    _SupportAccordionItem(
      title: 'Qué frases evitar',
      content: [
        '• “Échale ganas” o “ponle actitud”: el ánimo bajo no se quita con fuerza de voluntad.',
        '• “Hay gente que está peor”: minimiza lo que siente.',
        '• “Eso es pura flojera”: puede hacer que se cierre más.',
        '• Acompañar no es dar sermones, sino estar presente.',
      ],
    ),
    _SupportAccordionItem(
      title: 'Cómo ayudar en el día a día',
      content: [
        '• Invítale a actividades sencillas: caminar, comer juntos o ver una serie.',
        '• Ofrece ayuda concreta con algo pendiente, como un trámite o una tarea.',
        '• Sigue en contacto aunque no siempre conteste; un mensaje corto también acompaña.',
        '• Cuídate tú también: acompañar puede cansar.',
      ],
    ),
    _SupportAccordionItem(
      title: 'A dónde canalizar',
      content: [
        '• Recomiéndale siempre acudir con un psicólogo, sin presionar ni juzgar.',
        '• Ofrece buscar juntos un especialista o acompañarle a su primera cita.',
        '• Comparte la Línea de la Vida (800 911 2000): gratis y 24 horas.',
        '• Si habla de quitarse la vida o hay riesgo inmediato, llama al 911 y no lo/la dejes solo/a.',
      ],
    ),
  ];

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
              // Barra superior: botón regresar (si no está embebida) y botón rojo "Necesito ayuda ahora"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!widget.isEmbedded)
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

              // Título
              const Text(
                'Acompañar a alguien',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textoPrincipal,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tu compañía puede hacer una gran diferencia para alguien que pasa por días difíciles.',
                style: TextStyle(fontSize: 15, height: 1.4, color: AppColors.textoSecundario),
              ),
              const SizedBox(height: 20),
              const CalmScene(height: 130, mood: SceneMood.atardecer),
              const SizedBox(height: 20),

              // Lista tipo acordeón
              for (int i = 0; i < _items.length; i++) ...[
                _buildAccordionCard(i, _items[i]),
                const SizedBox(height: 12),
              ],

              const SizedBox(height: 16),

              // Tarjeta inferior de alerta: "Si crees que está en peligro"
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CrisisScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.alertaFondo,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFF9DEDA),
                        width: 1.2,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Si crees que está en peligro',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.alerta,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'No lo dejes solo/a y llama al 911 o a la Línea de la Vida: 800 911 2000.',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.textoPrincipal,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccordionCard(int index, _SupportAccordionItem item) {
    final isExpanded = _expandedIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _expandedIndex = isExpanded ? null : index;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E6E3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
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
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textoPrincipal,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textoPrincipal,
                      size: 24,
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFEAEAEA)),
                const SizedBox(height: 14),
                for (final line in item.content) ...[
                  Text(
                    line,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textoSecundario,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
