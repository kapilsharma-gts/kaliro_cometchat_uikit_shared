package com.cometchat.kaliro_cometchat_uikit_shared

import android.net.Uri
import java.util.HashMap

class CometChatFileInfo(val path: String?, val name: String?, val uri: Uri?, val size: Long, val bytes: ByteArray?) {
    class Builder {
        private var path: String? = null
        private var name: String? = null
        private var uri: Uri? = null
        private var size: Long = 0
        private  var bytes: ByteArray? = null
        fun withPath(path: String?): Builder {
            this.path = path
            return this
        }

        fun withName(name: String?): Builder {
            this.name = name
            return this
        }

        fun withSize(size: Long): Builder {
            this.size = size
            return this
        }

        fun withData(bytes: ByteArray?): Builder {
            this.bytes = bytes
            return this
        }

        fun withUri(uri: Uri?): Builder {
            this.uri = uri
            return this
        }

        fun build(): CometChatFileInfo {
            return CometChatFileInfo(path, name, uri, size, bytes)
        }
    }

    fun toMap(): HashMap<String, Any?> {
        val data = HashMap<String, Any?>()
        data["path"] = path
        data["name"] = name
        data["size"] = size
        data["bytes"] = bytes
        data["identifier"] = uri.toString()
        return data
    }
}