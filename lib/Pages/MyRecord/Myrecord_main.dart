import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/Components/Buttons/ElevationButton/ElevationButton.dart';
import 'package:test_flutter/Components/TitleText/TitleText.dart';
import 'package:test_flutter/Core/theme/colors.dart';
import 'package:test_flutter/Pages/MyRecord/Myrecord_detail.dart';

import '../../Components/Appbar/Appbar.dart';
import '../../Components/Buttons/TextButton/TextButton.dart';

class MyRecord extends StatefulWidget {
  const MyRecord({super.key});

  @override
  State<MyRecord> createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          setState(() {
            userName = doc.data()?['name'] ?? '사용자';
          });
        } else {
          setState(() {
            userName = '사용자';
          });
        }
      } catch (e) {
        setState(() {
          userName = '사용자';
        });
      }
    } else {
      setState(() {
        userName = '사용자';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 82),
                    child: TitleText(
                      text: userName == null ? '로딩 중...' : '$userName님의 기록',
                    ),
                  ),
                  const SizedBox(height: 55),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection('timerDatas')
                        .orderBy('createdAt', descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('기록이 없습니다.');
                      }

                      final records = snapshot.data!.docs;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: records.length,
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final data = records[index].data() as Map<String, dynamic>;

                          final title = data['title'] ?? '제목 없음';

                          final speed = data['speed'] ?? 0;

                          final speedUnitRaw = data['speedUnit'] ?? '';
                          final speedUnit = speedUnitRaw == '선택' ? '' : speedUnitRaw;

                          final distance = data['distance'] ?? 0;

                          final distanceUnitRaw = data['distanceUnit'] ?? '';
                          final distanceUnit = distanceUnitRaw == '선택' ? '' : distanceUnitRaw;

                          return Center(
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: TextBtn(
                                text: '$title\n$speed $speedUnit\n$distance $distanceUnit',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MyRecordDetail()),
                                  );
                                },
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 90,
                                borderColor: AppColors.secondary,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(child: DeleteBtn()),
            ),
          ],
        ),
      ),
    );
  }

  Widget DeleteBtn() {
    return ElevationBtn(
      onPressed: () {},
      width: 80,
      height: 50,
      text: '',
      child: Image.asset(
        'assets/images/trashimg.png',
        height: 30,
        width: 30,
      ),
    );
  }
}
