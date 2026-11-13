import 'package:flutter/material.dart';

class SmallStep {
  const SmallStep({required this.id, required this.text, required this.minutes});

  final String id;
  final String text;
  final int minutes;
}

class StepGroup {
  const StepGroup({
    required this.title,
    required this.icon,
    required this.steps,
  });

  final String title;
  final IconData icon;
  final List<SmallStep> steps;
}

/// Actividades breves para cuando todo cuesta más trabajo.
/// La idea es empezar por algo pequeño y lograble.
const stepGroups = <StepGroup>[
  StepGroup(
    title: 'Mover el cuerpo',
    icon: Icons.directions_walk_rounded,
    steps: [
      SmallStep(id: 'caminar', text: 'Camina 5 minutos, aunque sea dentro de casa', minutes: 5),
      SmallStep(id: 'estirar', text: 'Estírate durante 2 minutos', minutes: 2),
      SmallStep(id: 'luz', text: 'Abre la cortina o la ventana y deja entrar luz', minutes: 1),
    ],
  ),
  StepGroup(
    title: 'Cuidarte',
    icon: Icons.self_improvement_rounded,
    steps: [
      SmallStep(id: 'agua', text: 'Toma un vaso de agua', minutes: 1),
      SmallStep(id: 'ducha', text: 'Date una ducha o lávate la cara', minutes: 10),
      SmallStep(id: 'comer', text: 'Come algo, aunque sea pequeño', minutes: 10),
    ],
  ),
  StepGroup(
    title: 'Conectar',
    icon: Icons.chat_bubble_rounded,
    steps: [
      SmallStep(id: 'mensaje', text: 'Mándale un mensaje a alguien que aprecias', minutes: 2),
      SmallStep(id: 'saludar', text: 'Platica un momento con alguien de tu casa', minutes: 5),
      SmallStep(id: 'cancion', text: 'Escucha una canción que te guste', minutes: 4),
    ],
  ),
  StepGroup(
    title: 'Lograr algo pequeño',
    icon: Icons.task_alt_rounded,
    steps: [
      SmallStep(id: 'cama', text: 'Tiende tu cama u ordena un solo cajón', minutes: 5),
      SmallStep(id: 'pendiente', text: 'Termina una tarea pequeña que tenías pendiente', minutes: 10),
      SmallStep(id: 'gusto', text: 'Dedica 10 minutos a algo que antes disfrutabas', minutes: 10),
    ],
  ),
];

List<SmallStep> get allSmallSteps => [
      for (final group in stepGroups) ...group.steps,
    ];
