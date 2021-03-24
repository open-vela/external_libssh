#
# Copyright (C) 2020 Xiaomi Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include $(APPDIR)/Make.defs

CFLAGS += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" $(APPDIR)/external/zlib}
CFLAGS += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" $(APPDIR)/external/mbedtls/include}
CFLAGS += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" $(APPDIR)/external/libssh/include}
CFLAGS += ${shell $(INCDIR) $(INCDIROPT) "$(CC)" $(APPDIR)/external/libssh}

SKIP  = src/dh_crypto.c src/ecdh_crypto.c src/ecdh_gcrypt.c src/gcrypt_missing.c
SKIP += src/gssapi.c src/libcrypto.c src/libcrypto-compat.c src/libgcrypt.c
SKIP += src/pki_crypto.c src/pki_gcrypt.c
SKIP += src/threads/libcrypto.c src/threads/libgcrypt.c src/threads/winlocks.c
CSRCS = $(filter-out $(SKIP), $(wildcard src/*.c src/external/*.c src/threads/*.c))

ifneq ($(CONFIG_UTILS_SSH),)
PROGNAME = scp ssh sshd
MAINSRC = examples/libssh_scp.c examples/ssh_client.c examples/ssh_server.c
CSRCS += examples/authentication.c examples/connect_ssh.c examples/knownhosts.c

PRIORITY = $(CONFIG_UTILS_SSH_PRIORITY)
STACKSIZE = $(CONFIG_UTILS_SSH_STACKSIZE)
MODULE = $(CONFIG_UTILS_SSH)
endif

include $(APPDIR)/Application.mk
