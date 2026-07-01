import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 52,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.search,color: Colors.grey,),
              SizedBox(width: 10,),
              Expanded(child: Text("search products, brands, categories",
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              )),
              SizedBox(width: 10,),
              Container(
                height:34,
                width: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.tune,
                color: Theme.of(context).primaryColor,
                  size: 19,
              ))
            ],
          ),
        ),
        ),
      ),
    );
  }
}
