import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search(this._searchClicked, this._controller, this._searchBoxAnimation, this.destinations);
  final bool _searchClicked;
  final TextEditingController _controller;
  final Animation _searchBoxAnimation;
  final List<dynamic> destinations;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Future<List<dynamic>> getSearchResults(String pattern, var destinations) async {
    List<dynamic> searchResults = List();
    for (var destination in destinations) {
      if (destination["location"].toString().toUpperCase().contains(pattern.toUpperCase()) && pattern.length >= 4) {
        searchResults.add(destination);
      }
    }
    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget._searchClicked ? false : true,
      child: FadeTransition(
        opacity: widget._searchBoxAnimation,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TypeAheadField(
              direction: AxisDirection.up,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              textFieldConfiguration: TextFieldConfiguration(
                controller: widget._controller,
                obscureText: false,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      print("Search clicked");
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 23,
                    ),
                  ),
                  hintText: "Search",
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return getSearchResults(pattern, widget.destinations);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: suggestion["imageURL"],
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                            strokeWidth: 2.5,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/noImage.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    suggestion["location"],
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    suggestion["date"].toDate().toString().substring(0, 11),
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  trailing: Text(
                    suggestion["capacity"].toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                // Navigator.pushReplacement(
                //   context,
                //   new MaterialPageRoute(
                //     builder: (context) => SingleEventPage(widget.user,suggestion, widget.userRole, widget.userID, widget.preferredCategories,"SearchTab"),
                //   ),
                // );
              },
              noItemsFoundBuilder: (value) {
                return Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Text(
                    "No Items Found!",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
