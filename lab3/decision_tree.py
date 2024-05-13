import numpy as np
from collections import Counter


class Node:
    def __init__(self, feature=None, threshold=0.0, left=None, right=None, *, value=None):
        self.feature = feature
        self.threshold = threshold
        self.left = left
        self.right = right
        self.value = value

    def is_leaf_node(self):
        return self.value is not None

class DecisionTree:
    def __init__(self, min_samples_split=2, max_depth=100, n_features=None):
        self.min_samples_split = min_samples_split
        self.max_depth = max_depth
        self.n_features = n_features
        self.root = None

    def fit(self, X, y):
        self.n_features = X.shape[1] if self.n_features is None else min(self.n_features, X.shape[1])
        self.root = self._grow_tree(X, y)

    def _grow_tree(self, X, y, depth=0):
        num_samples, num_features = X.shape
        num_labels = len(np.unique(y))
        if (depth >= self.max_depth
                or num_labels == 1
                or num_samples < self.min_samples_split):
            counter = Counter(y)
            leaf_value = counter.most_common(1)[0][0]
            return Node(value=leaf_value)
        best_feature, best_threshold = self._best_split(X, y)
        left_indices, right_indices = self._split(X[:, best_feature], best_threshold)
        left_subtree = self._grow_tree(X[left_indices], y[left_indices], depth + 1)
        right_subtree = self._grow_tree(X[right_indices], y[right_indices], depth + 1)
        return Node(feature=best_feature, threshold=best_threshold, left=left_subtree, right=right_subtree)

    def _best_split(self, X, y):
        best_information_gain = -1
        best_threshold = None
        best_feature = None
        features = np.random.choice(X.shape[1], self.n_features, replace=False)
        for feature in features:
            X_column = X[:, feature]
            thresholds = np.unique(X_column)
            for threshold in thresholds:
                information_gain = self._information_gain(y, X_column, threshold)
                if information_gain > best_information_gain:
                    best_information_gain = information_gain
                    best_threshold = threshold
                    best_feature = feature
        return best_feature, best_threshold

    def _information_gain(self, y, feature_values, threshold):
        entropy = self._entropy(y)
        left_indices, right_indices = self._split(feature_values, threshold)

        information_gain = entropy - (((len(left_indices) / len(y)) * self._entropy(y[left_indices])) +
                                      ((len(right_indices) / len(y)) * self._entropy(y[right_indices])))
        return information_gain

    def _split(self, X_column, split_threshold):
        left_indices = np.argwhere(X_column <= split_threshold).flatten()
        right_indices = np.argwhere(X_column > split_threshold).flatten()
        return left_indices, right_indices

    def _entropy(self, y):
        hist = np.bincount(y)
        probabilities = (hist / len(y))
        entropy = -np.sum([probability * np.log2(probability) for probability in probabilities if probability > 0])
        return entropy

    def _traverse_tree(self, x, node):
        if node.is_leaf_node():
            return node.value
        if x[node.feature] <= node.threshold:
            return self._traverse_tree(x, node.left)
        return self._traverse_tree(x, node.right)

    def predict(self, X):
        return np.array([self._traverse_tree(x, self.root) for x in X])
