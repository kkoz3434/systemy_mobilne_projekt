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
  const [message, setMessage] = useState('Measure time');

  function isPrime(n: number) {
    if (n < 2) {
      return false;
    }
    for (let i = 2; i <= n / 2; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }

  function findPrimesInRange(startN: number, end: number) {
    let primes: Array<number> = [];
    for (let i = startN; i <= end; i++) {
      if (isPrime(i)) {
        primes.push(i);
      }
    }
    return primes;
  }

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.buttonRow}>
        <Button
          title="Find primes"
          onPress={() => {
            const start = performance.now();

            for (let i = 0; i < 100; i++) {
              findPrimesInRange(0, 10000);
            }
            const stop = performance.now();
            const myMessage = `${stop - start} miliseconds`;
            console.log(myMessage);
            setMessage(myMessage);
          }}
        />
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
