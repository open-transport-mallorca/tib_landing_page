import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  late Animation<Color?> _colorAnimation3;

  late final MeshGradientController _meshGradientController;

  List<String> prefixes = [
    'Travel easily',
    'Explore Mallorca',
    'Discover new places',
    'Find your way',
  ];

  @override
  void initState() {
    super.initState();

    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorAnimation1 = RainbowColorTween([const Color(0xff6d83ec), const Color(0xff6d83ec), const Color(0xfffcb156)])
        .animate(_textAnimationController);
    _colorAnimation2 = RainbowColorTween([const Color(0xff6d83ec), const Color(0xffc157d1), const Color(0xffc157d1)])
        .animate(_textAnimationController);
    _colorAnimation3 = RainbowColorTween([const Color(0xff6d83ec), const Color(0xffc157d1), const Color(0xff6d83ec)])
        .animate(_textAnimationController);

    _meshGradientController = MeshGradientController(
      points: [
        MeshGradientPoint(
          position: const Offset(
            0.5,
            0.2,
          ),
          color: const Color.fromARGB(255, 255, 241, 86),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.5,
            0.6,
          ),
          color: const Color.fromARGB(255, 236, 109, 109),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.7,
            0.3,
          ),
          color: const Color(0xffc157d1),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.4,
            0.8,
          ),
          color: const Color.fromARGB(255, 51, 198, 231),
        ),
      ],
      vsync: this,
    );

    Timer.periodic(const Duration(seconds: 101), (timer) async => await _animateBackground());
    _animateBackground();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _meshGradientController.dispose();
    super.dispose();
  }

  Future<void> _animateBackground() async {
    await _meshGradientController.animateSequence(
      duration: const Duration(seconds: 10),
      sequences: [
        AnimationSequence(
          pointIndex: 0,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _meshGradientController.points.value[0].color,
          ),
          interval: const Interval(
            0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 1,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _meshGradientController.points.value[1].color,
          ),
          interval: const Interval(
            0.25,
            0.75,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 2,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _meshGradientController.points.value[2].color,
          ),
          interval: const Interval(
            0.5,
            1,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 3,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _meshGradientController.points.value[3].color,
          ),
          interval: const Interval(
            0.75,
            1,
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.5,
            child: MeshGradient(
              controller: _meshGradientController,
              options: MeshGradientOptions(
                blend: 5,
                noiseIntensity: 0,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("logo.png", height: 150),
              const SizedBox(height: 12),
              AnimatedBuilder(
                animation: _textAnimationController,
                builder: (context, child) {
                  return ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [
                          _colorAnimation1.value!,
                          _colorAnimation2.value!,
                          _colorAnimation3.value!,
                        ],
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                    },
                    child: AnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 1,
                        pause: Duration.zero,
                        onFinished: () => _textAnimationController.forward(),
                        animatedTexts: [
                          TyperAnimatedText(
                            'TIB',
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(fontSize: 100, fontWeight: FontWeight.w900),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ]),
                  );
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: AnimatedTextKit(
                    pause: const Duration(milliseconds: 2000),
                    animatedTexts: List.generate(
                      prefixes.length,
                      (index) => TyperAnimatedText(
                        prefixes[index],
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 0),
                            blurRadius: 10,
                          ),
                        ]),
                        speed: const Duration(milliseconds: 100),
                      ),
                    )),
              ),
              const SizedBox(height: 60),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: const Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    BadgeButton(
                        url: "https://play.google.com/store/apps/details?id=com.yarosfpv.tib",
                        asset: "assets/play-badge.png",
                        height: 75),
                    BadgeButton(
                        url: "https://apps.apple.com/us/app/tib/id6502532920",
                        asset: "assets/appstore-badge.png",
                        height: 75),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}

class BadgeButton extends StatefulWidget {
  const BadgeButton({super.key, required this.url, this.height, required this.asset});

  final String url;
  final double? height;
  final String asset;

  @override
  State<BadgeButton> createState() => _BadgeButtonState();
}

class _BadgeButtonState extends State<BadgeButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedOpacity(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        opacity: _isHovering ? 0.8 : 1,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: Image.asset(
            widget.asset,
            height: widget.height ?? 100,
          ),
        ),
      ),
    );
  }
}
