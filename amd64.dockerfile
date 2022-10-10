# :: Header
	FROM ubuntu:22.04
    ENV BAZEL_VERSION=5.3.1

# :: Run
	USER root

	# :: prepare
        RUN set -ex; \
            apt update -y; \
            apt install -y \
                apt-transport-https \
                curl \
                gnupg; \
            curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg; \
            mv bazel-archive-keyring.gpg /usr/share/keyrings; \
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list;

	# :: install
		RUN set -ex; \
			apt update -y; \
            apt install -y \
                bazel-${BAZEL_VERSION} \
                nodejs \
                npm; \
            npm install -g @bazel/bazelisk;