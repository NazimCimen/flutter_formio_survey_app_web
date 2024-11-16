part of '../view/answer_survey_preview.dart';

class _PublisherInfo extends StatelessWidget {
  const _PublisherInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yayınlayan',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        SizedBox(
          height: ConstantSizes.small.value,
        ),
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            Text(
              '  Nazım Çimen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShowSurveyCoverImage extends StatelessWidget {
  const _ShowSurveyCoverImage({
    required this.surveyCoverImage,
  });

  final String surveyCoverImage;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ImageAspectRatioEnum.surveyImage.ratio,
      child: Image.network(
        surveyCoverImage,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text('Image could not be loaded'),
          );
        },
      ),
    );
  }
}
