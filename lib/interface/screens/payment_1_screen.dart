import 'package:flutter/material.dart';

class Payment1Screen extends StatelessWidget {
  const Payment1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8EBFF),
            Colors.white,
          ],
          stops: [0.3, 0.7],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Get Dubai Connect Premium\nfor Your Business',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 28,
                height: 1.0, 
                letterSpacing: -0.01, 
                color: Colors.black,
              ),
            ),
            
          ],
        ),
      ),
    ));
  }
}

// import 'package:flutter/material.dart';
// class Payment1Screen extends StatelessWidget {
//   const Payment1Screen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFFE8EBFF),
//               Colors.white,
//             ],
//             stops: [0.3, 0.7],
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Get Dubai Connect Premium\nfor Your Business',
//               style: TextStyle(
//                 fontFamily: 'Manrope',
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 30),

//             // Timeline features
//             featureItem(isFirst: true),
//             const SizedBox(height: 16),
//             featureItem(),
//             const SizedBox(height: 16),
//             featureItem(isLast: true),

//             const SizedBox(height: 30),

//             // View Plan Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF001F61),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'View Plan',
//                   style: TextStyle(
//                     fontFamily: 'Manrope',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Skip Now Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: OutlinedButton(
//                 onPressed: () {},
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Color(0xFF001F61)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Skip Now',
//                   style: TextStyle(
//                     fontFamily: 'Manrope',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: Color(0xFF001F61),
//                   ),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             // Bottom Text
//             const Center(
//               child: Text(
//                 'Discover the right subscription to boost your business visibility and network.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Manrope',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget featureItem({bool isFirst = false, bool isLast = false}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             if (!isFirst)
//               Container(
//                 width: 2,
//                 height: 16,
//                 color: Colors.blue.shade200,
//               ),
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE8EBFF),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.blue.shade100),
//               ),
//               child: const Icon(
//                 Icons.lock_outline,
//                 size: 18,
//                 color: Color(0xFF001F61),
//               ),
//             ),
//             if (!isLast)
//               Container(
//                 width: 2,
//                 height: 40,
//                 color: Colors.blue.shade200,
//               ),
//           ],
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 'Unlock Business Features',
//                 style: TextStyle(
//                   fontFamily: 'Manrope',
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Gain access to exclusive business tools, premium listings, event invites, and verified badge for credibility.',
//                 style: TextStyle(
//                   fontFamily: 'Manrope',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                   color: Colors.black87,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
