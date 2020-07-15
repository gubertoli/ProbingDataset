
    // !!! This file is generated using emlearn !!!

    #include <eml_trees.h>
    

EmlTreesNode scan_detection_nodes[18] = {
  { 12, 1.5, 1, 5 },
  { 7, 62.5, 2, 15 },
  { 7, 61.5, 3, 8 },
  { 23, 1024.5, 4, 5 },
  { 23, 1023.5, 5, 6 },
  { -1, 0, -1, -1 },
  { 4, 0.5, 7, 5 },
  { -1, 1, -1, -1 },
  { 20, 0.5, 9, 12 },
  { 23, 256.0, 10, 11 },
  { 2, 891.0, 7, 5 },
  { 23, 40312.0, 7, 7 },
  { 15, 42.0, 13, 14 },
  { 4, 0.5, 7, 5 },
  { 23, 15838.5, 5, 7 },
  { 7, 252.5, 5, 16 },
  { 23, 512.0, 5, 17 },
  { 20, 0.5, 7, 5 } 
};

int32_t scan_detection_tree_roots[1] = { 0 };

EmlTrees scan_detection = {
        18,
        scan_detection_nodes,	  
        1,
        scan_detection_tree_roots,
    };

static inline int32_t scan_detection_predict_tree_0(const float *features, int32_t features_length) {
          if (features[12] < 1.5) {
              if (features[7] < 62.5) {
                  if (features[7] < 61.5) {
                      if (features[23] < 1024.5) {
                          if (features[23] < 1023.5) {
                              return 0;
                          } else {
                              if (features[4] < 0.5) {
                                  return 1;
                              } else {
                                  return 0;
                              }
                          }
                      } else {
                          return 0;
                      }
                  } else {
                      if (features[20] < 0.5) {
                          if (features[23] < 256.0) {
                              if (features[2] < 891.0) {
                                  return 1;
                              } else {
                                  return 0;
                              }
                          } else {
                              if (features[23] < 40312.0) {
                                  return 1;
                              } else {
                                  return 1;
                              }
                          }
                      } else {
                          if (features[15] < 42.0) {
                              if (features[4] < 0.5) {
                                  return 1;
                              } else {
                                  return 0;
                              }
                          } else {
                              if (features[23] < 15838.5) {
                                  return 0;
                              } else {
                                  return 1;
                              }
                          }
                      }
                  }
              } else {
                  if (features[7] < 252.5) {
                      return 0;
                  } else {
                      if (features[23] < 512.0) {
                          return 0;
                      } else {
                          if (features[20] < 0.5) {
                              return 1;
                          } else {
                              return 0;
                          }
                      }
                  }
              }
          } else {
              return 0;
          }
        }
        

int32_t scan_detection_predict(const float *features, int32_t features_length) {

        int32_t votes[2] = {0,};
        int32_t _class = -1;

        _class = scan_detection_predict_tree_0(features, features_length); votes[_class] += 1;
    
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
    