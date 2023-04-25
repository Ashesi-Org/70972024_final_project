import 'package:flutter/material.dart';
import 'post_model.dart';
import 'api_service.dart';

class AshesiConnect extends StatefulWidget {
  const AshesiConnect({super.key});

  @override
  State<AshesiConnect> createState() => _AshesiConnectState();
}

class _AshesiConnectState extends State<AshesiConnect> {
  late List<PostModel>? _postModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _postModel = (await ApiService().getPosts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return _postModel == null || _postModel!.isEmpty
        ? const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
      itemCount: _postModel!.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Sent by: " + _postModel![index].email),
                  Text(_postModel![index].timestamp),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_postModel![index].text),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
