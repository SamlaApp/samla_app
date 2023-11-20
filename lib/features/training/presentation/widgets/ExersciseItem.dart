import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class ExerciseItem extends StatefulWidget {
  final int? id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final List<String> secondaryMuscles;
  final LinearGradient gradient;
  final VoidCallback onRemove;

  const ExerciseItem({
    Key? key,
    this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.instructions,
    required this.secondaryMuscles,
    required this.gradient,
    required this.onRemove,
  }) : super(key: key);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {

  final String _baseURL = 'https://samla.mohsowa.com/api/training/image/';

  bool _isRemoved = false;
  bool _isExpanded = false;
  bool _isAddedToPlan = false;
  void _handleRemove() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to remove this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.onRemove();
                setState(() {
                  _isRemoved = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Remove"),
            ),
          ],
        );
      },
    );
  }

  void _handleAddToPlan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add to Plan"),
          content: const Text("Do you want to add this exercise to your plan?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isAddedToPlan) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.darken,
        borderRadius: BorderRadius.circular(10),
        gradient: widget.gradient,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            title: Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: _handleAddToPlan,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _buildSummaryRow(),
          if (_isExpanded) _buildExpandedContent(),
        ],
      ),
    );
  }

  Widget _buildSummaryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailContainer('Body Part', widget.bodyPart),
          _buildDetailContainer('Equipment', widget.equipment),
        ],
      ),
    );
  }


  Widget _buildDetailContainer(String label, String value) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            width: 160,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.white, // Match the background color
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Text(
                label,
                style: TextStyle(
                  color: theme_darkblue,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _baseURL + widget.gifUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Target: ', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                    _buildDetailText('${widget.target}.'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Secondary Muscles: ', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                    _buildDetailText('${widget.secondaryMuscles.join(', ')}.'),
                  ],
                ),
              ],
            ),
          ),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column
              children: [
                const Text(
                  'Instructions:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                _buildDetailText(widget.instructions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.visible,
        decoration: TextDecoration.none,
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.justify
    );
  }

}
