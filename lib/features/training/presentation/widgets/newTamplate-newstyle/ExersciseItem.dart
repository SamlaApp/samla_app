import 'package:flutter/material.dart';

class ExerciseItem extends StatefulWidget {
  final int? id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final Set<String> secondaryMuscles;
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
        borderRadius: BorderRadius.circular(10),
        gradient: widget.gradient,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.gifUrl,
                width: 120,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
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
                  ),
                ),
                IconButton(
                  onPressed: _handleAddToPlan,
                  icon: const Icon(
                    Icons.add,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 150,
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
          left: 15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.white, // Match the background color
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
          Row(
            children: [
              Text('Target: ', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              _buildDetailText('${widget.target}'),
            ],
          ),
          Row(
            children: [
              Text('Secondary Muscles: ', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              _buildDetailText('${widget.secondaryMuscles.join(', ')}'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column
            children: [
              Text(
                'Instructions:',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              _buildDetailText(widget.instructions),
            ],
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
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }

}
