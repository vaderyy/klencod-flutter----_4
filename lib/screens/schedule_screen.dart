import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الجدول الدراسي'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'السبت'),
              Tab(text: 'الأحد'),
              Tab(text: 'الاثنين'),
              Tab(text: 'الثلاثاء'),
              Tab(text: 'الأربعاء'),
              Tab(text: 'الخميس'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('جدول السبت')),
            Center(child: Text('جدول الأحد')),
            Center(child: Text('جدول الاثنين')),
            Center(child: Text('جدول الثلاثاء')),
            Center(child: Text('جدول الأربعاء')),
            Center(child: Text('جدول الخميس')),
          ],
        ),
      ),
    );
  }
}