/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import { Text, View, FlatList, Image, StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  listItem: {
    padding: 10
  },
  listContainer: {
    flex: 1,
    flexDirection: "row"
  },
  listSeparator: {
    height: 1,
    opacity: 0.6,
    backgroundColor: "gray",
  },
  movieInfo: {
    flex: 1,
    justifyContent: "center",
    marginLeft: 10
  },
  movieTitle: {
    fontSize: 17,
    fontWeight: "bold"
  },
  movieSubtitle: {
    fontSize: 12,
    color: "gray"
  }
});

class ListItem extends Component {
  render() {
    return (
        <View style={styles.listItem}>
          <View style={styles.listContainer}>
            <Image source={this.props.movie.image} style={{width: 50, height: 50}}/>
            <View style={styles.movieInfo}>
              <Text style={styles.movieTitle}>{this.props.movie.title}</Text>
              <Text style={styles.movieSubtitle}>{this.props.movie.year}</Text>
            </View>
          </View>
        </View>
    )
  }
}

export default class App extends Component {
  state = {
    movies: [
      {
        id: 1,
        title: "The Lion King",
        year: 2019,
        image: {
          uri: "https://pbs.twimg.com/profile_images/1134173490620354561/V9Au2vRZ_400x400.jpg"
        }
      }, {
        id: 2,
        title: "The Avengers - Endgame",
        year: 2019,
        image: {
          uri: "https://images-na.ssl-images-amazon.com/images/I/91epzdXTTHL._SX300_.jpg"
        }
      }
    ]
  };

  renderSeparator = () => {
    return (
        <View style={styles.listSeparator} />
    );
  };

  render() {
    return (
        <View style={{flex: 1}}>
          <FlatList
              data={this.state.movies}
              renderItem={({item}) => <ListItem movie={item} />}
              ItemSeparatorComponent={this.renderSeparator}
          />
        </View>
    );
  }
}
