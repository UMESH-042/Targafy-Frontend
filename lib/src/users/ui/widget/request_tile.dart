import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:targafy/src/users/ui/model/request_user_model.dart';

class RequestTile extends StatelessWidget {
  final String? logoUrl;
  final String name;
  final DateTime date;
  final ContactNumber contactNumber;
  final Function() onAccept;
  final Function() onReject;

  const RequestTile({
    Key? key,
    this.logoUrl,
    required this.name,
    required this.date,
    required this.contactNumber,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            _buildLogo(),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${contactNumber.countryCode} ${contactNumber.number}",
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Date: ${_formattedDate(date)}',
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return logoUrl != null
        ? CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                imageUrl: logoUrl!,
                placeholder: _buildPlaceholder,
                errorWidget: _buildError,
              ),
            ),
          )
        : CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Text(
              name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onReject,
          ),
        ),
        const SizedBox(width: 8.0),
        CircleAvatar(
          backgroundColor: Colors.green,
          child: IconButton(
            icon: const Icon(Icons.done, color: Colors.white),
            onPressed: onAccept,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context, String url) {
    return Container(
      color: Colors.grey,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String url, dynamic error) {
    return const Icon(
      Icons.error,
      color: Colors.red,
    );
  }

  String _formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

