import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doalink/theme/app_colors.dart';

class OnboardingCarousel extends StatefulWidget {
  final List<OnboardingSlide> slides;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool showIndicators;
  final VoidCallback? onSlideChanged;

  const OnboardingCarousel({
    super.key,
    required this.slides,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.showIndicators = true,
    this.onSlideChanged,
  });

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _onSlideChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _fadeController.reset();
    _fadeController.forward();
    widget.onSlideChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CarouselSlider.builder(
            itemCount: widget.slides.length,
            itemBuilder: (context, index, realIndex) {
              final slide = widget.slides[index];
              return FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSlideCard(slide, index),
              );
            },
            options: CarouselOptions(
              height: 350,
              viewportFraction: 0.85,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              autoPlay: widget.autoPlay,
              autoPlayInterval: widget.autoPlayInterval,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) => _onSlideChanged(index),
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (widget.showIndicators) _buildIndicators(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSlideCard(OnboardingSlide slide, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            slide.backgroundColor ?? Colors.white,
            (slide.backgroundColor ?? Colors.white),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: slide.imageWidget ??
                    Image.asset(
                      slide.imagePath!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
              ),
            ),
            _buildSlideText(widget.slides[_currentIndex]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.slides.asMap().entries.map((entry) {
        final index = entry.key;
        final isActive = index == _currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.orange_500
                : AppColors.orange_500.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSlideText(OnboardingSlide slide) {
    return Container(
      key: ValueKey(_currentIndex),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: slide.titleColor ?? Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: slide.accentColor ?? AppColors.orange_500,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: slide.descriptionColor ?? Colors.grey[600],
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class OnboardingSlide {
  final String title;
  final String description;
  final String? imagePath;
  final Widget? imageWidget;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? titleColor;
  final Color? descriptionColor;

  const OnboardingSlide({
    required this.title,
    required this.description,
    this.imagePath,
    this.imageWidget,
    this.icon,
    this.backgroundColor,
    this.accentColor,
    this.titleColor,
    this.descriptionColor,
  });
}

class DoaLinkSlides {
  static List<OnboardingSlide> get slides => [
        const OnboardingSlide(
          title: "Conecte-se com Quem Precisa",
          description:
              "Encontre pessoas e organizações próximas que precisam de doações em tempo real.",
          imagePath: "assets/images/img2.png",
          icon: Icons.connect_without_contact,
          backgroundColor: Color(0xFFF8F9FA),
          accentColor: AppColors.blue_600,
        ),
        const OnboardingSlide(
          title: "Doe com Facilidade",
          description:
              "Publique suas doações de forma simples e segura. Roupas, alimentos, móveis e muito mais.",
          imagePath: "assets/images/img1.png",
          icon: Icons.volunteer_activism,
          backgroundColor: Color(0xFFF0F8FF),
          accentColor: AppColors.orange_500,
        ),
        const OnboardingSlide(
          title: "Impacto Real na Comunidade",
          description:
              "Veja o impacto das suas doações e ajude a construir uma comunidade mais solidária.",
          imagePath: "assets/images/img3.png",
          icon: Icons.favorite,
          backgroundColor: Color(0xFFF5F5F5),
          accentColor: Color(0xFFE91E63),
        ),
      ];
}
