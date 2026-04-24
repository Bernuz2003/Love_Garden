import 'dart:math';
import 'package:flutter/material.dart';

class BeeWidget extends StatefulWidget {
  const BeeWidget({Key? key}) : super(key: key);

  @override
  State<BeeWidget> createState() => _BeeWidgetState();
}

class _BeeWidgetState extends State<BeeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _wobbleController;
  final Random _random = Random();

  // Current position (may be off-screen to simulate exiting)
  double _top = -60;
  double _left = -60;
  bool _visible = false;
  bool _facingLeft = false;

  final List<String> _messages = [
      "Sei il mio raggio di sole preferito. ☀️",

    "Ho cercato in tutto il giardino, ma il fiore più bello sei tu. 🌸",

    "Ti amo più di quanto l’ape ami il suo miele. 🍯",

    "Ogni giorno che passa sono più grato di averti. ❤️",

    "Sei la melodia più bella della mia giornata. 🎶",

    "Sei il mio 'per sempre' in un mondo che corre. ⏳",

    "Volevo solo ricordarti che sei immensamente amata. 🌹",

    "Il nostro amore sta crescendo benissimo, guarda che fiori! 🌷",

    "Anche nelle giornate di pioggia, tu mi fai fiorire. 🌧️",

    "Le nostre radici sono forti, non temiamo nessuna tempesta. 💪",

    "Annaffio ogni giorno il pensiero di noi due. 💦",

    "Sei la primavera che non finisce mai. 🌿",

    "Insieme possiamo far crescere qualsiasi cosa. ✨",

    "Quel 4 ottobre è iniziato il capitolo più bello della mia vita. 📕",

    "Ogni giorno 4 il mio cuore batte un po' più forte. 💓",

    "Sei mesi (e oltre!) di noi, e non vedo l'ora del prossimo capitolo. 🗓️",

    "Il nostro '4' è la mia coordinata preferita nel mondo. 🗺️",

    "Sei più forte di quanto pensi, e io sono sempre qui con te. 🛡️",

    "Posso restare in silenzio accanto a te finché non torna il sole? ☁️",

    "Anche se oggi ti senti un cactus, per me sei preziosa. 🌵",

    "Non devi essere sempre perfetta, a me piaci proprio così. 🤍",

    "Fai un respiro profondo. Io faccio il tifo per te, sempre. 📣",

    "Zzz... Passavo di qui solo per darti un bacio volante! 💋",

    "Oggi sei così dolce che mi sono confusa! 🐝",

    "Volevo pungere chiunque ti faccia arrabbiare, ma ho preferito portarti un fiore. 🌻",

    "Ronzo di felicità da quando stiamo insieme. 🎵",
  ];

  @override
  void initState() {
    super.initState();
    _wobbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scheduleNextAppearance();
  }

  /// Schedules the bee to appear after a random delay.
  void _scheduleNextAppearance() async {
    // Wait 8–20 seconds before appearing
    final waitSeconds = 8 + _random.nextInt(13);
    await Future.delayed(Duration(seconds: waitSeconds));
    if (!mounted) return;

    _enterScreen();
  }

  /// Move the bee onto the screen to a random visible position.
  void _enterScreen() async {
    if (!mounted) return;

    final size = MediaQuery.of(context).size;
    // Target: somewhere in the sky area (top 45% of screen)
    final targetTop = 40.0 + _random.nextDouble() * (size.height * 0.35);
    final targetLeft = 30.0 + _random.nextDouble() * (size.width - 80);

    setState(() {
      _visible = true;
      _top = targetTop;
      _left = targetLeft;
      _facingLeft = targetLeft > size.width / 2;
    });

    // The bee stays visible for a few waypoints, then exits
    await _doWaypoints(size);
  }

  /// The bee moves through 2–3 random waypoints, then exits off-screen.
  Future<void> _doWaypoints(Size size) async {
    final waypointCount = 2 + _random.nextInt(2);

    for (int i = 0; i < waypointCount; i++) {
      await Future.delayed(Duration(seconds: 3 + _random.nextInt(4)));
      if (!mounted) return;

      final newTop = 30.0 + _random.nextDouble() * (size.height * 0.35);
      final newLeft = 20.0 + _random.nextDouble() * (size.width - 60);

      setState(() {
        _facingLeft = newLeft < _left;
        _top = newTop;
        _left = newLeft;
      });
    }

    // Now exit the screen
    await Future.delayed(Duration(seconds: 3 + _random.nextInt(3)));
    if (!mounted) return;

    _exitScreen(size);
  }

  /// Animate the bee off-screen and schedule the next appearance.
  void _exitScreen(Size size) {
    if (!mounted) return;

    // Pick a random exit direction
    final exitDirection = _random.nextInt(3); // 0=left, 1=right, 2=top
    setState(() {
      switch (exitDirection) {
        case 0:
          _left = -80;
          _facingLeft = true;
          break;
        case 1:
          _left = size.width + 80;
          _facingLeft = false;
          break;
        default:
          _top = -80;
          break;
      }
    });

    // After the animation completes, hide and schedule next
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _visible = false);
      _scheduleNextAppearance();
    });
  }

  @override
  void dispose() {
    _wobbleController.dispose();
    super.dispose();
  }

  void _showMessage(BuildContext context) {
    final message = _messages[_random.nextInt(_messages.length)];
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) => _BeeBubble(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 4),
      curve: Curves.easeInOutCubic,
      top: _top,
      left: _left,
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: GestureDetector(
          onTap: () => _showMessage(context),
          child: AnimatedBuilder(
            animation: _wobbleController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  2 * sin(_wobbleController.value * 3.14),
                  6 * _wobbleController.value,
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: _facingLeft
                      ? Matrix4.rotationY(3.14159)
                      : Matrix4.identity(),
                  child: const Text('🐝', style: TextStyle(fontSize: 28)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _BeeBubble — a delicate floating speech bubble for the bee's messages
// ---------------------------------------------------------------------------
class _BeeBubble extends StatefulWidget {
  final String message;

  const _BeeBubble({required this.message});

  @override
  State<_BeeBubble> createState() => _BeeBubbleState();
}

class _BeeBubbleState extends State<_BeeBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );
    _fadeController.forward();

    // Auto-dismiss after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        _fadeController.reverse().then((_) {
          if (mounted) Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Align(
        alignment: const Alignment(0, -0.3),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF8E1), Color(0xFFFFF3E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFE082),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.2),
                  offset: const Offset(0, 6),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🐝', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Color(0xFF5D4037),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
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
