
void* my_memcpy (void* dst, const void* src, unsigned long size) {
    for (unsigned long i = 0; i < size; i++) {
        ((char*)dst)[i] = ((const char*)src)[i];
    }
    return dst;
}
