import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class SimpleRecorder extends StatefulWidget {
  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();

    await _audioRecorder?.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized || _isRecording) return;

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    await _audioRecorder!.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized || !_isRecording) return;

    await _audioRecorder!.stopRecorder();

    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    if (_audioRecorder != null) {
      _audioRecorder!.closeRecorder();
      _audioRecorder = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : null,
              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: SimpleRecorder()));
