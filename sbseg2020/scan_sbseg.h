
    // !!! This file is generated using emlearn !!!

    #include <eml_trees.h>
    

EmlTreesNode scan_sbseg_nodes[49] = {
  { 2, 64.5, 1, 48 },
  { 7, 0.5, 2, 40 },
  { 6, 38.0, 3, 33 },
  { 2, 44.5, 4, 26 },
  { 4, 0.5, 5, 15 },
  { 14, 520.5, 6, 9 },
  { 14, 506.5, 7, 8 },
  { -1, 0, -1, -1 },
  { -1, 1, -1, -1 },
  { 14, 65524.0, 10, 13 },
  { 2, 42.5, 11, 12 },
  { 14, 1064.0, 7, 7 },
  { 14, 1026.0, 8, 7 },
  { 3, 4.0, 14, 7 },
  { 6, 22.0, 8, 7 },
  { 1, 0.5, 16, 20 },
  { 14, 506.5, 7, 17 },
  { 14, 1300.0, 18, 19 },
  { 14, 1024.5, 8, 8 },
  { 6, 22.0, 7, 7 },
  { 11, 0.5, 21, 24 },
  { 0, 106.5, 22, 23 },
  { 4, 1.5, 8, 7 },
  { 0, 38766.5, 7, 7 },
  { 14, 28872.5, 7, 25 },
  { 14, 29043.0, 8, 7 },
  { 5, 18.5, 27, 30 },
  { 14, 64248.0, 7, 28 },
  { 14, 64276.0, 29, 7 },
  { 0, 50937.0, 7, 8 },
  { 14, 21780.0, 31, 32 },
  { 0, 192.5, 7, 7 },
  { 14, 46454.0, 8, 7 },
  { 14, 15749.0, 7, 34 },
  { 14, 16472.0, 35, 36 },
  { 2, 62.0, 7, 8 },
  { 14, 64157.0, 7, 37 },
  { 14, 64520.0, 38, 7 },
  { 0, 55526.5, 39, 8 },
  { 0, 55379.5, 8, 8 },
  { 14, 511.5, 7, 41 },
  { 0, 2.0, 7, 42 },
  { 14, 16498.0, 43, 7 },
  { 4, 13.0, 44, 7 },
  { 11, 0.5, 45, 46 },
  { 12, 0.5, 8, 8 },
  { 14, 1023.5, 7, 47 },
  { 4, 0.5, 8, 8 },
  { 1, 0.5, 7, 7 } 
};

int32_t scan_sbseg_tree_roots[1] = { 0 };

EmlTrees scan_sbseg = {
        49,
        scan_sbseg_nodes,	  
        1,
        scan_sbseg_tree_roots,
    };

static inline int32_t scan_sbseg_predict_tree_0(const float *features, int32_t features_length) {
          if (features[2] < 64.5) {
              if (features[7] < 0.5) {
                  if (features[6] < 38.0) {
                      if (features[2] < 44.5) {
                          if (features[4] < 0.5) {
                              if (features[14] < 520.5) {
                                  if (features[14] < 506.5) {
                                      return 0;
                                  } else {
                                      return 1;
                                  }
                              } else {
                                  if (features[14] < 65524.0) {
                                      if (features[2] < 42.5) {
                                          if (features[14] < 1064.0) {
                                              return 0;
                                          } else {
                                              return 0;
                                          }
                                      } else {
                                          if (features[14] < 1026.0) {
                                              return 1;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  } else {
                                      if (features[3] < 4.0) {
                                          if (features[6] < 22.0) {
                                              return 1;
                                          } else {
                                              return 0;
                                          }
                                      } else {
                                          return 0;
                                      }
                                  }
                              }
                          } else {
                              if (features[1] < 0.5) {
                                  if (features[14] < 506.5) {
                                      return 0;
                                  } else {
                                      if (features[14] < 1300.0) {
                                          if (features[14] < 1024.5) {
                                              return 1;
                                          } else {
                                              return 1;
                                          }
                                      } else {
                                          if (features[6] < 22.0) {
                                              return 0;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  }
                              } else {
                                  if (features[11] < 0.5) {
                                      if (features[0] < 106.5) {
                                          if (features[4] < 1.5) {
                                              return 1;
                                          } else {
                                              return 0;
                                          }
                                      } else {
                                          if (features[0] < 38766.5) {
                                              return 0;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  } else {
                                      if (features[14] < 28872.5) {
                                          return 0;
                                      } else {
                                          if (features[14] < 29043.0) {
                                              return 1;
                                          } else {
                                              return 0;
                                          }
                                      }
                                  }
                              }
                          }
                      } else {
                          if (features[5] < 18.5) {
                              if (features[14] < 64248.0) {
                                  return 0;
                              } else {
                                  if (features[14] < 64276.0) {
                                      if (features[0] < 50937.0) {
                                          return 0;
                                      } else {
                                          return 1;
                                      }
                                  } else {
                                      return 0;
                                  }
                              }
                          } else {
                              if (features[14] < 21780.0) {
                                  if (features[0] < 192.5) {
                                      return 0;
                                  } else {
                                      return 0;
                                  }
                              } else {
                                  if (features[14] < 46454.0) {
                                      return 1;
                                  } else {
                                      return 0;
                                  }
                              }
                          }
                      }
                  } else {
                      if (features[14] < 15749.0) {
                          return 0;
                      } else {
                          if (features[14] < 16472.0) {
                              if (features[2] < 62.0) {
                                  return 0;
                              } else {
                                  return 1;
                              }
                          } else {
                              if (features[14] < 64157.0) {
                                  return 0;
                              } else {
                                  if (features[14] < 64520.0) {
                                      if (features[0] < 55526.5) {
                                          if (features[0] < 55379.5) {
                                              return 1;
                                          } else {
                                              return 1;
                                          }
                                      } else {
                                          return 1;
                                      }
                                  } else {
                                      return 0;
                                  }
                              }
                          }
                      }
                  }
              } else {
                  if (features[14] < 511.5) {
                      return 0;
                  } else {
                      if (features[0] < 2.0) {
                          return 0;
                      } else {
                          if (features[14] < 16498.0) {
                              if (features[4] < 13.0) {
                                  if (features[11] < 0.5) {
                                      if (features[12] < 0.5) {
                                          return 1;
                                      } else {
                                          return 1;
                                      }
                                  } else {
                                      if (features[14] < 1023.5) {
                                          return 0;
                                      } else {
                                          if (features[4] < 0.5) {
                                              return 1;
                                          } else {
                                              return 1;
                                          }
                                      }
                                  }
                              } else {
                                  return 0;
                              }
                          } else {
                              return 0;
                          }
                      }
                  }
              }
          } else {
              if (features[1] < 0.5) {
                  return 0;
              } else {
                  return 0;
              }
          }
        }
        

int32_t scan_sbseg_predict(const float *features, int32_t features_length) {

        int32_t votes[2] = {0,};
        int32_t _class = -1;

        _class = scan_sbseg_predict_tree_0(features, features_length); votes[_class] += 1;
    
        int32_t most_voted_class = -1;
        int32_t most_voted_votes = 0;
        for (int32_t i=0; i<2; i++) {

            if (votes[i] > most_voted_votes) {
                most_voted_class = i;
                most_voted_votes = votes[i];
            }
        }
        return most_voted_class;
    }
    