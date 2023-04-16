import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BuildVideoNews extends StatefulWidget {
  const BuildVideoNews({super.key});
  @override
  State<BuildVideoNews> createState() => _BuildVideoNews();
}

Route routeVideoNews() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const BuildVideoNews(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 3);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _BuildVideoNews extends State<BuildVideoNews> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  double widthInput1 = 0;
  double heightInput1 = 0;
  double width3 = 0;

  double widthtru = 0;
  double heightInput2 = 0;

  late FocusNode myFocusNode;
  late FocusNode myFocusNode2;

  final myController = TextEditingController();

  final listComment = [];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _controller.play();

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    myFocusNode.dispose();
    myController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double width2 = width - 160;

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          //video
          Positioned(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return SizedBox(
                    width: width,
                    height: height,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    ),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          // control video player
          Positioned(
            child: GestureDetector(
              onTap: () => setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it.
                  _controller.play();
                }
              }),
              child: Container(
                color: Colors.black26,
              ),
            ),
          ),
          // video progress bar
          Positioned(
              top: 7,
              left: 20,
              // right: 20,
              height: 7,
              width: (width - 40),
              child: VideoProgressIndicator(_controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                      backgroundColor: Colors.white24,
                      // bufferedColor: Colors.blueGrey,
                      playedColor: Colors.white))),
          // title bar
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.blue)),
                      child: const CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'GirlTiktok',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          // list comments
          Positioned(
            left: 20,
            right: 30,
            bottom: 90,
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listComment.length,
                  itemBuilder: (context, index) {
                    if (listComment[index] != '') {
                      return Container(
                          height: 20,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black26,
                          ),
                          child: Center(
                              child: Text(
                            listComment[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )));
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  }),
            ),
          ),
          // textfield 1
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 40,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    heightInput1 = height;
                    widthInput1 = width;
                    myFocusNode.requestFocus();
                  }),
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black,
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Gửi tin nhắn',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Icon(
                    Icons.tag_faces_sharp,
                    size: 35,
                  ),
                ),
                Container(
                  width: 50,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Icon(
                    Icons.tag_faces_sharp,
                    size: 35,
                  ),
                ),
                Container(
                  width: 50,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Icon(
                    Icons.tag_faces_sharp,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          // textfield 2
          Positioned(
              child: SizedBox(
            width: widthInput1,
            height: heightInput1,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      color: Colors.black26,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          widthInput1 = 0;
                          heightInput1 = 0;

                          heightInput2 = 0;
                          FocusScope.of(context).unfocus();
                        }),
                      )),
                ),
                Container(
                  color: Colors.black,
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.image,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.mic_rounded,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: width - 160,
                        height: 40,
                        child: TextField(
                          controller: myController,
                          onChanged: (value) => setState(() {
                            heightInput2 = 60;
                            widthtru = 80;
                            width3 = width;
                            myFocusNode2.requestFocus();
                          }),
                          onTap: () => setState(() {
                            heightInput2 = 60;
                            widthtru = 80;
                            width3 = width;
                            myFocusNode2.requestFocus();
                          }),
                          focusNode: myFocusNode,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.tag_faces,
                                color: Colors.blue,
                                size: 22,
                              ),
                              hintText: 'Nhắn tin',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              fillColor: Colors.white24,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          // textfield 3
          Positioned(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              color: Colors.black,
              width: width3,
              height: heightInput2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              onPressed: () => setState(() {
                                heightInput2 = 0;
                                width3 = 0;

                                myFocusNode2.unfocus();
                              }),
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: width2 + widthtru,
                            height: 40,
                            child: TextField(
                              controller: myController,
                              focusNode: myFocusNode2,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.tag_faces,
                                    color: Colors.blue,
                                    size: 22,
                                  ),
                                  hintText: 'Nhắn tin',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                  filled: true,
                                  fillColor: Colors.white24,
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(40))),
                            ),
                          ),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                              onPressed: () => setState(() {
                                    listComment.add(myController.text);
                                    widthInput1 = 0;
                                    heightInput1 = 0;
                                    width3 = 0;
                                    heightInput2 = 0;
                                    myFocusNode.unfocus();
                                    myFocusNode2.unfocus();

                                    myController.text = "";
                                  }),
                              icon: const Icon(
                                Icons.send,
                                size: 20,
                                color: Colors.blue,
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ])),
        ]),
      ),
    );
  }
}
