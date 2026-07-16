import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String? mobile;
  final double outstanding;
  final int overdueDays;

  final VoidCallback? onTap;
  final VoidCallback? onLedger;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onMore;

  const CustomerCard({
    super.key,
    required this.name,
    this.mobile,
    required this.outstanding,
    required this.overdueDays,
    this.onTap,
    this.onLedger,
    this.onWhatsApp,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    final status = _status(outstanding);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 6,
              height: 110,
              color: status.color,
            ),
            Expanded(
              child: Container(
                color: status.background,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                          status.color.withOpacity(.15),
                          child: Text(
                            name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: status.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                mobile?.isEmpty ?? true
                                    ? "Mobile not available"
                                    : mobile!,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: onMore,
                          icon: const Icon(Icons.more_vert),
                          visualDensity:
                          VisualDensity.compact,
                          splashRadius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Text(
                          "Outstanding",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₹${outstanding.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: status.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _CustomerStatus _status(double outstanding) {
    if (outstanding > 0) {
      return _CustomerStatus(
        Colors.red,
        Colors.red.shade50,
      );
    }

    if (outstanding < 0) {
      return _CustomerStatus(
        Colors.blue,
        Colors.blue.shade50,
      );
    }

    return _CustomerStatus(
      Colors.green,
      Colors.green.shade50,
    );
  }
}

class _CustomerStatus {
  final Color color;
  final Color background;

  const _CustomerStatus(
      this.color,
      this.background,
      );
}