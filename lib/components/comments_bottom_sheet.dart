import 'package:flutter/material.dart';

class Comment {
  final String id;
  final String username;
  final String userAvatar;
  final String text;
  final String timeAgo;
  final int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.text,
    required this.timeAgo,
    required this.likes,
    this.isLiked = false,
  });
}

class CommentsBottomSheet extends StatefulWidget {
  final String postId;
  final int initialCommentCount;

  const CommentsBottomSheet({
    super.key,
    required this.postId,
    required this.initialCommentCount,
  });

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();

  // Sample comments data
  List<Comment> _comments = [
    Comment(
      id: '1',
      username: 'mike_racing',
      userAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      text: 'Beautiful car! Is this the JZX90 or JZX100 generation?',
      timeAgo: '2h',
      likes: 3,
    ),
    Comment(
      id: '2',
      username: 'sarah_auto',
      userAvatar:
          'https://images.unsplash.com/photo-1494790108755-2616b72b6698?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      text: 'Love the wheel setup! 💯',
      timeAgo: '1h',
      likes: 7,
      isLiked: true,
    ),
    Comment(
      id: '3',
      username: 'car_spotter_rw',
      userAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      text:
          'I see this car around Kimisagara all the time. Owner takes great care of it!',
      timeAgo: '45m',
      likes: 12,
    ),
    Comment(
      id: '4',
      username: 'tuning_expert',
      userAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      text:
          'Those are some nice modifications. Looks like it has a body kit and lowered suspension.',
      timeAgo: '30m',
      likes: 5,
    ),
    Comment(
      id: '5',
      username: 'kigali_cars',
      userAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      text:
          'Classic! These Mark IIs are getting rare to find in good condition.',
      timeAgo: '15m',
      likes: 8,
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.insert(
          0,
          Comment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            username: 'current_user', // This would be the current user
            userAvatar:
                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
            text: _commentController.text.trim(),
            timeAgo: 'now',
            likes: 0,
          ),
        );
      });
      _commentController.clear();

      // Scroll to top to show new comment
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _toggleCommentLike(String commentId) {
    setState(() {
      final comment = _comments.firstWhere((c) => c.id == commentId);
      comment.isLiked = !comment.isLiked;
    });
  }

  void _navigateToUserProfile(String username, String userAvatar) {
    Navigator.pop(context); // Close bottom sheet first
    Navigator.pushNamed(
      context,
      '/user_profile',
      arguments: {
        'userId': username,
        'username': username,
        'userAvatar': userAvatar,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_comments.length}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Comments list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture
                      GestureDetector(
                        onTap: () => _navigateToUserProfile(
                          comment.username,
                          comment.userAvatar,
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(comment.userAvatar),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Comment content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Username and comment text
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: comment.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ' '),
                                  TextSpan(text: comment.text),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Time ago and like button
                            Row(
                              children: [
                                Text(
                                  comment.timeAgo,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                if (comment.likes > 0) ...[
                                  Text(
                                    '${comment.likes} ${comment.likes == 1 ? 'like' : 'likes'}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                                GestureDetector(
                                  onTap: () => _toggleCommentLike(comment.id),
                                  child: Text(
                                    'Reply',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Like button
                      GestureDetector(
                        onTap: () => _toggleCommentLike(comment.id),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 16,
                            color: comment.isLiked ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Comment input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Current user profile picture
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Text input
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Send button
                  GestureDetector(
                    onTap: _addComment,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to show the comments bottom sheet
void showCommentsBottomSheet(
  BuildContext context,
  String postId,
  int commentCount,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        CommentsBottomSheet(postId: postId, initialCommentCount: commentCount),
  );
}
