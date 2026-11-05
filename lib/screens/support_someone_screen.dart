import 'package:flutter/material.dart';
import '../core_theme.dart';
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
        '• Cambios notorios y repentinos en el estado de ánimo o energía.',
        '• Aislamiento social o desconexión de actividades que antes disfrutaba.',
        '• Frases directas o indirectas de desesperanza (“ya nada tiene sentido”, “sería mejor si no estuviera”).',
        '• Descuido marcado del autocuidado, sueño o alimentación.',
      ],
    ),
    _SupportAccordionItem(
      title: 'Cómo iniciar la conversación',
      content: [
        '• Elige un momento privado, tranquilo y sin prisas.',
        '• Pregunta desde la empatía genuina: “He notado que has estado callado/a últimamente, ¿cómo te has sentido de verdad?”.',
        '• Escucha más de lo que hablas. No intentes resolver su vida en una sola charla.',
        '• Valida sus sentimientos: “Entiendo que te sientas abrumado/a, gracias por compartirlo conmigo”.',
      ],
    ),
    _SupportAccordionItem(
      title: 'Qué frases evitar',
      content: [
        '• Evita frases invalidantes como: “No te preocupes, hay gente peor que tú” o “Échale ganas”.',
        '• Evita minimizar su dolor: “Eso no es para tanto” o “Es una tontería”.',
        '• Evita sermonear o centrar la plática en tus propias experiencias.',
        '• Recuerda que acompañar no es dar lecciones morales, sino estar presente.',
      ],
    ),
    _SupportAccordionItem(
      title: 'A dónde canalizar',
      content: [
        '• Invita a buscar apoyo psicológico profesional sin presionar ni juzgar.',
        '• Ofrece ayuda práctica: “¿Te gustaría que busquemos juntos un especialista o te acompañe a la sala de espera?”.',
        '• Comparte números de atención gratuita como la Línea de la Vida (800 911 2000).',
        '• Si hay riesgo inminente, llama al 911 y no lo dejes solo/a.',
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
              const SizedBox(height: 24),

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
