import React, {useState} from 'react';
import {StyleSheet, View, Text} from 'react-native';
import Video from 'react-native-video';

const App = () => {
  const background = require('./assets/video_example.mp4');

  const [message, setMessage] = useState('');

  let startLoading: number = undefined!;

  return (
    <View style={styles.container}>
      <Text>{message}</Text>
      <Video
        // Can be a URL or a local file.
        source={background}
        // Store reference
        // ref={ref => {
        //   this.player = ref;
        // }}
        onLoadStart={() => {
          startLoading = performance.now();
        }}
        onLoad={() => {
          const stopLoading = performance.now();
          const myMessage = `${stopLoading - startLoading} miliseconds`;
          console.log(myMessage);
          setMessage(myMessage);
        }}
        // Callback when remote video is buffering
        // onBuffer={onBuffer}
        // Callback when video cannot be loaded
        // onError={onError}
        style={styles.backgroundVideo}
      />
    </View>
  );
};
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'flex-end',
    paddingBottom: 100,
  },
  backgroundVideo: {
    position: 'absolute',
    top: 0,
    left: 0,
    bottom: 0,
    right: 0,
  },
});
export default App;
