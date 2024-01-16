import React, {useRef, useState} from 'react';
import {
  Animated,
  View,
  StyleSheet,
  Button,
  SafeAreaView,
  Text,
} from 'react-native';

const App = () => {
  // fadeAnim will be used as the value for opacity. Initial Value: 0
  const fadeAnim = useRef(new Animated.Value(0)).current;
  const [message, setMessage] = useState('Measure time');

  const animate = () => {
    // Will change fadeAnim value to 1 in 5 seconds
    const start = performance.now();
    Animated.timing(fadeAnim, {
      toValue: 5,
      duration: 5000,
      useNativeDriver: true,
    }).start(() => {
      const stop = performance.now();
      const myMessage = `${stop - start} miliseconds`;
      console.log(myMessage);
      setMessage(myMessage);
    });
  };
  const spin = fadeAnim.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg'],
  });

  return (
    <SafeAreaView style={styles.container}>
      <Animated.View
        style={[
          {flexDirection: 'row'},
          {
            // Bind opacity to animated value
            transform: [{rotate: spin}],
          },
        ]}>
        <View>
          <View
            style={{
              height: 100,
              width: 100,
              borderRadius: 50,
              backgroundColor: 'powderblue',
            }}
          />
          <View
            style={{
              height: 100,
              width: 100,
              borderRadius: 50,
              backgroundColor: 'orange',
            }}
          />
        </View>
        <View>
          <View
            style={{
              height: 100,
              width: 100,
              borderRadius: 50,
              backgroundColor: 'pink',
            }}
          />
          <View
            style={{
              height: 100,
              width: 100,
              borderRadius: 50,
              backgroundColor: 'khaki',
            }}
          />
        </View>
      </Animated.View>
      <View style={styles.buttonRow}>
        <Button title="Animate" onPress={animate} />
      </View>
      <Text>{message}</Text>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  fadingText: {
    fontSize: 28,
  },
  buttonRow: {
    flexBasis: 100,
    justifyContent: 'space-evenly',
    marginVertical: 16,
  },
});

export default App;
